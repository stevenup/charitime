module SessionHelper
  def log_in code, au_type
    Rails.logger.info '********** in log_in method **********'
    openid = Modules::Wechat.get_user_openid code
    unless openid.nil?
      user = User.find_by(:openid => openid)
      if user.nil?
        info = Modules::Wechat.get_user_info_sns_user_info openid unless au_type.nil?
        info = Modules::Wechat.get_user_info_sns_base openid if au_type.nil?
        user = User.new info
        user.save
      end
      session[:user_id] = user.id
    else
      raise 'Get openid error.'
    end
    Rails.logger.info '********** leave log_in method **********'
  end

  def current_user
    @current_user ||= User.find_by(:id => session[:user_id])
    # @current_user ||= User.first
  end

  def logged_in?
    !current_user.nil?
  end
end
