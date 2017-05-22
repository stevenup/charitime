class BaseController < ApplicationController
  before_action :auth_user

  def auth_user
    if current_user
      openid = current_user.openid
      return if current_user.updated_at > (Time.now - 1.hour)

      fetch_info(openid) do |info|
        if current_user['nickname'] != info['nickname'] || current_user['headimgurl'] != info['headimgurl']
          current_user.update_attributes(info)
        end
      end
    else
      code = params['code']
      if code
        openid = Modules::Wechat.get_user_openid code
        return unless openid

        fetch_info(openid) do |info|
          User.find_or_create_by(openid: openid) do |user|
            user.update_attributes(info) if user.new_record? || user.updated_at > (Time.now - 1.hour)
            session[:openid] = user.openid
          end
        end
      else
        # NOTE:
        #   1. For user who goes into charitime the first time.
        #   2. Then redirect to auth url
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
    # @current_user = User.last
  end
end
