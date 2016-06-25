class WepayController < ApplicationController
  include SessionHelper

  def init_wx_js_info
    url = params['url']
    if url
      appid     = Settings.wechat.appid
      timestamp = Time.now.to_i
      noncestr  = SecureRandom.hex(10)
      info      = {
        :appid      => appid,
        :timestamp  => timestamp,
        :noncestr   => noncestr,
        :signature  => Modules::Wechat.get_sign(timestamp, noncestr, url)
      }
    end
    render json: { data: info }
  end

  def unified_order
    id  = params[:id]
    order_detail = OrderDetail.find_by :order_id => id

    params = {
      body:         order_detail.product_name,
      out_trade_no: order_detail.order_id,
      total_fee:    order_detail.order.total_price * 100,
      openid:       current_user.openid,
      trade_type:   'JSAPI',
      notify_url:   'http://charitime.nonprofit.cn/wepay/notify',
      spbill_create_ip: '127.0.0.1'
    }

    res = Wepay::Service.invoke_unifiedorder params
    if res['return_code'] == 'SUCCESS'
      render json: { result: 'fail', data: res['err_code_des'] } if res['result_code'] == 'FAIL'
      render json: { result: 'success', data: res['prepay_id'] } if res['result_code'] == 'SUCCESS'
    end
  end

  def init_jspay_info
    prepay_id = params[:prepay_id]
    if prepay_id
      appid     = Settings.wechat.appid
      timestamp = Time.now.to_i
      noncestr  = SecureRandom.hex(10)
      params    = {
        :appId      => appid,
        :timeStamp  => timestamp,
        :nonceStr   => noncestr,
        :package    => prepay_id,
        :signType   => 'MD5'
      }
      paysign = Wepay::Sign.generate params
      render json: { data: params.merge({ :paySign => paysign }) }
    end
  end

  def notify
    Rails.logger.info '******************** in notify *****************'
    result = Hash.from_xml(request.body.read)["xml"]
    Rails.logger.info 'WXPay response is: '
    Rails.logger.info result
    if Wepay::Sign.verify? result
      Rails.logger.info '**** verify success, change order_status ****'
      out_trade_no = result['out_trade_no']
      order = Order.find_by(order_id: out_trade_no)
      order.update_attribute :order_status, 1
      render :xml => { return_code: "SUCCESS" }.to_xml(root: 'xml', dasherize: false)
    else
      Rails.logger.info '**** verify failed, change order_status ****'
      render :xml => { return_code: "FAIL", return_msg: "签名失败" }.to_xml(root: 'xml', dasherize: false)
    end
    Rails.logger.info '***************** leave notify *****************'
  end
end
