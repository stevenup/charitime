class InitJsInfoController < ApplicationController
  def init_js_info
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
end