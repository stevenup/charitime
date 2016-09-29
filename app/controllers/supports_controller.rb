class SupportsController < BaseController
  def index
  end

  def pay
    pid = params[:pid]
    @project = Project.find_by(:project_id => pid)
    @support = Support.where("user_id = ? and project_id = ?", current_user.id, pid).last
  end

  def create
    money              = params['money']
    pid                = params['pid']
    type               = params['type'].to_i
    support            = Support.new({ money: money, support_type: type })
    support.user_id    = current_user.id
    support.project_id = pid
    support.save if support
    redirect_to controller: 'supports', action: 'pay', pid: pid
  end

  def change_support_status
    id = params[:id]
    support = Support.find_by(user_id: current_user.id, project_id: id)
    if support
      support.update_attribute(:status, '1')
      render json: { status: 'success' }
    else
      render json: { status: 'failed'}
    end

  end
  private
  def support_params
    params.permit(:pid, :money, :type, :utf8, :authenticity_token, :commit)
  end
end
