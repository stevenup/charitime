class WepayController < ApplicationController
  skip_before_filter :verify_authenticity_token
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

  def unified_order
    Rails.logger.info '****************** in unified order *******************'
    id           = params[:id]
    order_detail = OrderDetail.find_by(:order_id => id)
    project      = Project.find_by(:project_id => id)
    support      = Support.find_by(user_id: current_user.id, project_id: id)

    # if - else 判断是支付订单还是使用维修支付为项目无偿捐赠
    if order_detail
      params = {
        body:         order_detail.product_name,
        out_trade_no: order_detail.order_id,
        total_fee:    (order_detail.order.total_price * 100).to_int,
        openid:       current_user.openid,
        trade_type:   'JSAPI',
        notify_url:   'http://charitime.nonprofit.cn/wepay/notify',
        spbill_create_ip: '127.0.0.1'
      }

      res = Wepay::Service.invoke_unifiedorder params
      if res['return_code'] == 'SUCCESS'
        render json: { result: 'success', data: res['prepay_id'] } if res['result_code'] == 'SUCCESS'
        render json: { result: 'fail', data: res['err_code_des'] } if res['result_code'] == 'FAIL'
      else
        render json: { result: 'fail', data: res['return_msg'] }
      end
      Rails.logger.info '**************** leave unified order *****************'

    elsif project and support
      params = {
        body:         project.project_name,
        out_trade_no: project.project_id,
        total_fee:    (support.money).to_int,
        openid:       current_user.openid,
        trade_type:   'JSAPI',
        notify_url:   'http://charitime.nonprofit.cn/wepay/notify',
        spbill_create_ip: '127.0.0.1'
      }

      res = Wepay::Service.invoke_unifiedorder params
      if res['return_code'] == 'SUCCESS'
        render json: { result: 'success', data: res['prepay_id'] } if res['result_code'] == 'SUCCESS'
        render json: { result: 'fail', data: res['err_code_des'] } if res['result_code'] == 'FAIL'
      else
        render json: { result: 'fail', data: res['return_msg'] }
      end
      Rails.logger.info '**************** leave unified order *****************'
    else
      render plain: '出错啦~~~'
    end
  end

  def refund_order
    Rails.logger.info '****************** in refund *******************'
    id = params[:id]
    order_detail = OrderDetail.find_by(:order_id => id)
    params = {
      total_fee:     (order_detail.order.total_price * 100).to_int,
      refund_fee:    (order_detail.order.total_price * 100).to_int,
      op_user_id:    Settings.wepay.mch_id,
      out_trade_no:  order_detail.order_id,
      out_refund_no: order_detail.out_refund_no
    }

    res = Wepay::Service.invoke_refund params
    if res['return_code'] == 'SUCCESS'
      if res['result_code'] == 'SUCCESS'
        order_detail.order.update_attribute(:order_status, -2)
        render json: { result: 'success' }
      else res['result_code'] == 'FAIL'
        render json: { result: 'fail', data: res['err_code_des'] }
      end
    else
      render json: { result: 'fail', data: res['return_msg'] }
    end
    Rails.logger.info '***************** leave refund *****************'
  end

  def notify
    Rails.logger.info '****************** in notify *******************'
    result = Hash.from_xml(request.body.read)["xml"]
    Rails.logger.info 'WXPay response is: '
    Rails.logger.info result
    if Wepay::Sign.verify? result
      Rails.logger.info '**** verify success, change order_status ****'
      out_trade_no   = result['out_trade_no']
      transaction_id = result['transaction_id']

      order = Order.find_by(order_id: out_trade_no)
      order.update_attributes({ order_status: 1, transaction_id: transaction_id })
      render :xml => { return_code: "SUCCESS" }.to_xml(root: 'xml', dasherize: false)
    else
      Rails.logger.info '**** verify failed, change order_status ****'
      render :xml => { return_code: "FAIL", return_msg: "签名失败" }.to_xml(root: 'xml', dasherize: false)
    end
    Rails.logger.info '***************** leave notify *****************'
  end
end
