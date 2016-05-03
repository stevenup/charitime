module Modules::Wechat
  def get_access_token
    _path = Settings.wechat.access_token
    return refresh_access_token unless File.exist?(_path)
    _file = File.open(_path, 'r')
    return refresh_access_token if _file.mtime < (1.9).hours.ago
    _token = _file.readlines.first
    return refresh_access_token if _token.blank?
    _token
  end

  def refresh_access_token
    _appid = Settings.wechat.appid
    _secret = Settings.wechat.secret
    _path = Settings.wechat.access_token
    raise('Got some error in wechat config') if _appid.blank? || _secret.blank? || _path.blank?

    _url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{ Settings.wechat.appid }&secret=#{ Settings.wechat.secret }"
    _info = HTTPClient.get _url
    _access_token = JSON.parse(_info.body)['access_token']

    raise('Get access token failed') if _access_token.blank?
    File.write(_path, _access_token)
    _access_token
  end

  def get_user_openid code
    Rails.logger.info '********** in get_user_openid method **********'
    _url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{ Settings.wechat.appid }&secret=#{ Settings.wechat.secret }&code=#{ code }&grant_type=authorization_code"
    _info = HTTPClient.get _url
    Rails.logger.info _info.body
    Rails.logger.info '*********** finish get_user_openid ************'
    JSON.parse(_info.body)['openid']
  end

  def get_user_info_sns_base openid
    Rails.logger.info '********** in get_user_info_sns_base method **********'
    _url = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=#{ get_access_token }&openid=#{ openid }&lang=zh_CN"
    _info = HTTPClient.get _url
    Rails.logger.info _info.body
    Rails.logger.info '************ finish get_user_info_sns_base ***********'
    JSON.parse(_info.body)
  end

  def get_user_info_sns_userinfo openid, access_token
    Rails.logger.info '********** in get_user_info_sns_user_info method **********'
    _url = "https://api.weixin.qq.com/sns/userinfo?access_token=#{ access_token }&openid=#{ openid }&lang=zh_CN"
    _info = HTTPClient.get _url
    Rails.logger.info _info.body
    Rails.logger.info '************ finish get_user_info_sns_userinfo ************'
    JSON.parse(_info.body)
  end
 
  def get_js_ticket
    _path = Settings.wechat.jsapi_ticket
    return refresh_js_ticket unless File.exist?(_path)
    _file = File.open(_path, 'r')
    return refresh_js_ticket if _file.mtime < (1.9).hours.ago
    _ticket = _file.readlines.first
    return refresh_js_ticket if _ticket.blank?
    _ticket
  end

  def refresh_js_ticket
    _url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=#{ get_access_token }&type=jsapi"
    _info = HTTPClient.get _url

    _ticket = JSON.parse(_info.body).fetch('ticket') { '' }
    raise('get ticket failure') if _ticket.blank?
    File.write(Settings.wechat.jsapi_ticket, _ticket)
    _ticket
  end

  def get_sign(timestamp, noncestr, url)
    _sign = Digest::SHA1.hexdigest("jsapi_ticket=#{ get_js_ticket }&noncestr=#{ noncestr }&timestamp=#{ timestamp }&url=#{ url }")
  end

  module_function :get_access_token, :refresh_access_token, :get_js_ticket, :refresh_js_ticket, :get_sign, :get_user_openid, :get_user_info_sns_base, :get_user_info_sns_userinfo
end
