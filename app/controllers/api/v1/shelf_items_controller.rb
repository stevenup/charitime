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

  def get_shelf_item
    id = params[:id]
    shelf_item = ShelfItem.find_by(:id => id)
    render json: shelf_item, status: :ok if shelf_item
  end

  def get_linked_project
    siid = params[:siid]
    shelf_item = ShelfItem.find_by_id(siid)
    if shelf_item
      project = shelf_item.project
      render json: project, status: :ok if project
    else
      render json: { result: 'FAIL' }
    end
  end
end