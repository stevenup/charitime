class SupportsController < BaseController
  def index

  end

  def create
    support = Support.new support_params
    support.user_id      = current_user.id
    support.save if support
    redirect_to controller: 'projects', action: 'detail', id: pid
  end

  def support_params
    params.require(:support).permit(:pid, :money, :type)
  end
end