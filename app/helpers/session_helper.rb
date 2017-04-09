module SessionHelper
  def log_in(code, au_type)
    Rails.logger.info '********** in log_in method **********'
    openid = Modules::Wechat.get_user_openid code
    if openid
      if au_type.nil?
        info = Modules::Wechat.get_user_info_sns_base openid
      else
        access_token = Modules::Wechat.get_access_token
        info = Modules::Wechat.get_user_info_sns_userinfo(openid, access_token)
      end
      user = User.find_by(:openid => openid)
      if user.nil?
        user = User.new info
        user.save
      end
      session[:user_id] = user.id if user
    else
      Rails.logger.info '******************** Get openid error ********************.'
    end
    Rails.logger.info '********** leave log_in method **********'
  end

  def update_user(code, au_type)
    openid = Modules::Wechat.get_user_openid code
    if openid
      if au_type.nil?
        info = Modules::Wechat.get_user_info_sns_base openid
      else
        access_token = Modules::Wechat.get_access_token
        info = Modules::Wechat.get_user_info_sns_userinfo(openid, access_token)
      end
      user = User.find_by(:openid => openid)
      if user and info
        user.update_attributes(info) if user['nickname'] != info['nickname'] or user['headimgurl'] != info['headimgurl']
      end
    else
      Rails.logger.info '******************** Get openid error ********************.'
    end
  end

  def current_user
    @current_user ||= User.find_by(:id => session[:user_id])
    # @current_user ||= User.last
  end

  def logged_in?
    current_user.nil?
  end
end
