class SupportsController < BaseController
  def index
    @supports = Support.where("user_id = ? and status = ?", current_user.id, 1).order(created_at: :desc)
  end

  def pay
    pid = params[:id]
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
    redirect_to support_pay_path(pid)
  end

  def show
    id = params[:id]
    @support = Support.where("user_id = ? and project_id = ?", current_user.id, id).last
  end

  private
  def support_params
    params.permit(:pid, :money, :type, :utf8, :authenticity_token, :commit)
  end
end
