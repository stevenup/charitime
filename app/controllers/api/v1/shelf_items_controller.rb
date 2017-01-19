class Api::V1::ShelfItemsController < ApplicationController
  def index
    @shelf_items = ShelfItem.all
    render json: @shelf_items, status: :ok
  end
end