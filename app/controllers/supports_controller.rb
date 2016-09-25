class SupportsController < BaseController
  def index
  end

  def create
    money              = params['money']
    pid                = params['pid']
    type               = params['type'].to_i
    support            = Support.new({ money: money, support_type: type })
    support.user_id    = current_user.id
    support.project_id = pid
    support.save if support
    redirect_to controller: 'projects', action: 'detail', id: pid
  end

  private
  def support_params
    params.permit(:pid, :money, :type, :utf8, :authenticity_token, :commit)
  end
end
