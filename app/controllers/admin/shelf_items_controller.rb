class Admin::ShelfItemsController < Admin::AuthenticatedController
  def off_shelf_list
    respond_to do |format|
      format.html
      format.json { get_rows }
    end
  end

  def on_shelf_list
    respond_to do |format|
      format.html
      format.json { get_rows_from_shelf }
    end
  end

  def recommended_list
    respond_to do |format|
      format.html
      format.json { get_rows_from_recommended_list }
    end
  end

  def edit
    @shelf_item = ShelfItem.new
    id =  params[:id]
    @product = Product.find_by :id => id
    render 'form', :layout =>  'bootstrap_modal'
  end

  def create
    id = params[:id]
    if ShelfItem.find_by :id => id
      create_or_update id, shelf_item_params
    else
      create_or_update 0, shelf_item_params
    end
  end

  def set_recommended
    id = params[:id]
    shelf_item = ShelfItem.find_by_id(id)

    if shelf_item && shelf_item.recommended != '1'
      shelf_item.recommended = '1'
      shelf_item.save
      redirect_to on_shelf_list_admin_shelf_items_path
    else
      render json: {data: 'Oops~ something is wrong'}
    end
  end

  def reset_recommended
    id = params[:id]
    shelf_item = ShelfItem.find_by_id(id)
    shelf_item.recommended = '0'
    shelf_item.save

    redirect_to recommended_list_admin_shelf_items_path
  end

  def pull_off_shelf
    id = params[:id]
    product = Product.find_by :id => id
    shelf_item = ShelfItem.find_by :id => id
    shelf_item.is_on_shelf = '0'
    shelf_item.recommended = '0'
    product.is_on_shelf = '0'
    product.save
    shelf_item.save

    redirect_to on_shelf_list_admin_shelf_items_path
  end

  private
  def get_rows
    dt = decode_datatables_params
    where_array = []
    where_array << "products.is_on_shelf = '0'"

    search_obj = {
        :include => [],
        :joins => [],
        :order => dt[:sort_statement],
        :conditions => [where_array.join(' AND ')]
    }

    @total_rows = Product.count(search_obj)
    @rows = Product.page(dt[:page]).per(dt[:per_page])
                .includes(search_obj[:include])
                .joins(search_obj[:joins])
                .order(search_obj[:order])
                .where(search_obj[:conditions])
  end

  def get_rows_from_shelf
    dt = decode_datatables_params
    where_array = []
    where_array << "shelf_items.is_on_shelf = '1'"

    search_obj = {
        :include => [],
        :joins => [],
        :order => dt[:sort_statement],
        :conditions => [where_array.join(' AND ')]
    }

    @total_rows = ShelfItem.count(search_obj)
    @rows = ShelfItem.page(dt[:page]).per(dt[:per_page])
                .includes(search_obj[:include])
                .joins(search_obj[:joins])
                .order(search_obj[:order])
                .where(search_obj[:conditions])

  end

  def get_rows_from_recommended_list
    dt = decode_datatables_params
    where_array = []
    where_array << "shelf_items.is_on_shelf = '1' and shelf_items.recommended = '1'"

    search_obj = {
        :include => [],
        :joins => [],
        :order => dt[:sort_statement],
        :conditions => [where_array.join(' AND ')]
    }

    @total_rows = ShelfItem.count(search_obj)
    @rows = ShelfItem.page(dt[:page]).per(dt[:per_page])
                .includes(search_obj[:include])
                .joins(search_obj[:joins])
                .order(search_obj[:order])
                .where(search_obj[:conditions])

  end

  def create_or_update(id, form_data)
    if id == 0
      product = Product.find_by :id => params[:id]
      merged_data = product.attributes.merge form_data
      shelf_item = ShelfItem.new merged_data
      shelf_item.is_on_shelf = '1'
      shelf_item.thumb = product.thumb
      product.is_on_shelf = '1'
      product.save
      shelf_item.save
    else
      product = Product.find_by :id => params[:id]
      product.is_on_shelf = '1'
      product.save
      shelf_item = ShelfItem.find_by :id => params[:id]
      data = product.attributes.merge form_data
      # @shelf_item.is_on_shelf = '1'
      #
      # @shelf_item.thumb = product.thumb

      shelf_item.update_attributes data
    end
    # response_after_save_json result, @shelf_item
    redirect_to off_shelf_list_admin_shelf_items_path
  end

  def shelf_item_params
    params.require(:shelf_item).permit(:price, :gyb_discount, :stock)
  end
end
