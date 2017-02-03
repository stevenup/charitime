class Api::V1::ShelfItemsController < ApplicationController
  def index
    param = params[:param]
    if param == 'recommended'
      shelf_items = ShelfItem.where('is_on_shelf = ? and recommended = ?', '1', '1')
      render json: shelf_items, status: :ok
    else
      shelf_items = ShelfItem.where('is_on_shelf = ?', '1')
      render json: shelf_items, status: :ok
    end
  end

  def linked_shelf_items
    pid = params[:pid]
    if pid
      shelf_items = ShelfItem.where('is_on_shelf = ? and project_id = ?', '1', pid)
      render json: shelf_items, status: :ok
    else
      render json: { data: 'no request params.' }
    end

  end
end