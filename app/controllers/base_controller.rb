class BaseController < ApplicationController
  include SessionHelper
  before_action :auth_user

  # 如果是分享出去的连接，拼url时加上au_type参数，用于判断oauth为sns_userinfo
  def auth_user
    Rails.logger.info '###################### Starting to auth user #########################'
    code    = params[:code]
    au_type = params[:type]
    if logged_in?
      log_in(code, au_type) if code
    end
    update_user(code, au_type) if code
  end
end
