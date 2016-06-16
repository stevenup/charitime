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
    count = params[:count]
    aid   = params[:aid]
    siid  = params[:siid]

    shelf_item = ShelfItem.find_by_id(siid)

    params = {
      body:         shelf_item.product_name,
      out_trade_no: shelf_item.product_id,
      total_fee:    shelf_item.price,
      openid:       current_user.openid,
      trade_type:   'JSAPI',
      notify_url:   'http://charitime.nonprofit.cn',
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
      render json: { data: params.merge({:paySign => paysign}) }
    end
  end

  def recv
  end
end
