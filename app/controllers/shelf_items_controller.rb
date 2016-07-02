class ShelfItemsController < BaseController
  def index
    @shelf_items = ShelfItem.where :is_on_shelf => '1'
  end

  def show
    @shelf_item = ShelfItem.find_by(:id => params[:id])
    @address    = Address.find_by({ user_id: current_user.id, default: '1' })  # the default value is used to mark the default address
  end
end
