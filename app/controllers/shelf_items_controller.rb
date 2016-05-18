class ShelfItemsController < ApplicationController
  def index
    @shelf_items = ShelfItem.where :is_on_shelf => '1'
  end

  def detail
    @shelf_item = ShelfItem.find_by(:id => params[:id])
  end
end
