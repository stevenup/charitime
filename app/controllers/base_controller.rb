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
        openid, access_token = Modules::Wechat.get_openid_and_access_token code
        return unless openid

        info = fetch_info(openid, access_token)
        user = User.find_by(openid: openid)
        if user.nil? || user.updated_at > (Time.now - 1.hour)
          user.update_attributes(info)
        end
        session[:openid] = user.openid
      else
        # NOTE:
        #   1. For user who goes into charitime the first time.
        #   2. Then redirect to auth url
        redirect_to(redirect_url) && return
      end
    end
  end

  def fetch_info(openid, *access_token)
    if access_token.blank?
      info = Modules::Wechat.get_user_info_sns_base(openid)
    else
      info = Modules::Wechat.get_user_info_sns_userinfo(openid, *access_token)
    end
    info
    # return if info['errcode'].present?
    # yield info if block_given?
  end

  def redirect_url
    url = request.url
    appid = Settings.wechat.appid
    'https://open.weixin.qq.com/connect/oauth2/authorize?appid=' + appid + '&redirect_uri=' + url + '&response_type=code&scope=snsapi_userinfo&state=12345#wechat_redirect'
  end

  private

  def current_user
    logger.info '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
    logger.info '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
    logger.info session[:openid]
    logger.info '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
    logger.info '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
    @current_user ||= User.find_by(openid: session[:openid])
    # @current_user = User.last
  end

  helper_method :current_user
end
