class BaseController < ApplicationController
  before_action :auth_user

  def auth_user
    if current_user
      openid = current_user.openid

      fetch_info(openid) do |info|
        if current_user['nickname'] != info['nickname'] || current_user['headimgurl'] != info['headimgurl']
          current_user.update_attributes(info)
        end
      end
    else
      code = params['code']
      if code
        openid = Modules::Wechat.get_user_openid code
        user = User.find_by_openid(openid) if openid

        fetch_info(openid) do |info|
          if user
            session[:openid] = user.openid if user.update_attributes(info)
          else
            new_user = User.new(info)
            session[:openid] = new_user.openid if new_user.save
          end
        end
      else
        redirect_to(redirect_url) && return
      end
    end
  end

  def fetch_info openid
    info = Modules::Wechat.get_user_info_sns_base openid
    return if info['errcode'].present?
    yield info if block_given?
  end

  def redirect_url
    url = request.url
    appid = Settings.wechat.appid
    'https://open.weixin.qq.com/connect/oauth2/authorize?appid=' + appid + '&redirect_uri=' + url + '&response_type=code&scope=snsapi_base&state=12345#wechat_redirect'
  end

  private

  def current_user
    @current_user ||= User.find_by(openid: session[:openid])
  end
end
