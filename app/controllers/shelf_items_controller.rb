class ShelfItemsController < ApplicationController
  def index
    @shelf_items = ShelfItem.all
  end

  def detail
    @shelf_item = ShelfItem.find_by(:id => params[:id])
  end
end
