class SupportsController < BaseController
  def index
    @supports = Support.where("user_id = ? and status = ?", current_user.id.to_s, '1').order(created_at: :desc)
  end

  def pay
    id       = params[:id]
    @support = Support.find_by(:id => id)
    @project = Project.find_by(:project_id => @support.project_id) if @support
  end

  def create
    # Get params from shelf_items#show page.
    siid         = params[:siid]
    count        = params[:count]
    if siid
      shelf_item = ShelfItem.find_by(:id => siid)
      money      = shelf_item.price * count.to_i if shelf_item
    else
      # If no params passed from shelf_items#show
      money      = params['money_option'].to_i
    end
    pid                        = params['pid']
    type                       = params['type'].to_i
    support                    = Support.new({ money: money * 100, support_type: type })
    support.user_id            = current_user.id.to_s
    support.project_id         = pid
    support.count              = count if count
    support.shelf_item_id      = siid if siid
    support.save if support
    redirect_to support_pay_path(id: support.id)
  end

  def detail
    id       = params[:id]
    @support = Support.find_by(:id => id)
  end

  private
  def support_params
    params.permit(:pid, :money_option, :type, :utf8, :authenticity_token, :commit)
  end
end
