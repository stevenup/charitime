require "openssl"
require "base64"
require "json"

module Modules::Wxapp

  def get_wxapp_openid_and_session_key code
    _appid      = Settings.wxapp.appid
    _secret     = Settings.wxapp.secret
    _code       = code
    _url        = "https://api.weixin.qq.com/sns/jscode2session?appid=#{ _appid }&secret=#{ _secret }&js_code=#{ _code }&grant_type=authorization_code"
    _info       = HTTPClient.get _url
    openid      = JSON.parse(_info.body)['openid']
    session_key = JSON.parse(_info.body)['session_key']
    [openid, session_key]
  end

  def sign_verified?(raw_data, session_key, signature)
    signature2 = Digest::SHA1.hexdigest("#{raw_data}""#{session_key}")
    signature2 == signature ? true : false
  end

  def wx_biz_data_decrypt(app_id, session_key, encrypted_data, iv)
    session_key    = Base64.decode64(session_key)
    encrypted_data = Base64.decode64(encrypted_data)
    iv             = Base64.decode64(iv)

    cipher     = OpenSSL::Cipher::AES128.new(:CBC)
    cipher.decrypt
    cipher.key = session_key
    cipher.iv  = iv

    decrypted_data = JSON.parse(cipher.update(encrypted_data) + cipher.final)
    raise('Invalid Buffer') if decrypted_data['watermark']['appid'] != app_id

    decrypted_data
  end

  module_function :get_wxapp_openid_and_session_key, :wx_biz_data_decrypt, :sign_verified?
end