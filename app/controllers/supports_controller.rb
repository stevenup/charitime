class SupportsController < BaseController
  def index
    @supports = Support.where("user_id = ? and status = ?", current_user.id.to_s, '1').order(created_at: :desc)
  end

  def pay
    pid = params[:id]
    @project = Project.find_by(:project_id => pid)
    @support = Support.where("user_id = ? and project_id = ?", current_user.id.to_s, pid).last
  end

  def create
    money_option       = params['money_option'].to_i
    puts '>>>>>>>>>>'
    puts money_option
    pid                = params['pid']
    type               = params['type'].to_i
    support            = Support.new({ money: money_option * 100, support_type: type })
    support.user_id    = current_user.id.to_s
    support.project_id = pid
    support.save if support
    redirect_to support_pay_path(pid)
  end

  def show
    pid = params[:pid]
    @support = Support.where("user_id = ? and project_id = ?", current_user.id.to_s, pid).last
  end

  private
  def support_params
    params.permit(:pid, :money_option, :type, :utf8, :authenticity_token, :commit)
  end
end
