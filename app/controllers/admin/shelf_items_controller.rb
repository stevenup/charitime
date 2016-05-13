class Admin::ShelfItemsController < Admin::BaseController
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

  def edit
    @shelf_item = ShelfItem.last
    render 'form', :layout =>  'bootstrap_modal'
  end

  def put_on_shelf
    flag = params[:flag]
    id = params[:id]
    product = Product.find_by :id => id
    shelf_item = ShelfItem.find_by :id => id
    if shelf_item
      shelf_item.update_attributes product.attributes
    else
      shelf_item = ShelfItem.new product.attributes
    end
    shelf_item.is_on_shelf = flag
    product.is_on_shelf = flag
    product.save
    shelf_item.save

    render json: {data: 'success'}
  end

  def pull_off_shelf
    flag = params[:flag]
    id = params[:id]
    product = Product.find_by :id => id
    shelf_item = ShelfItem.find_by :id => id
    shelf_item.is_on_shelf = flag
    product.is_on_shelf = flag
    product.save
    shelf_item.save

    render json: {data: 'success'}
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

  def product_params
    params.require(:product).permit(:product_name, :thumb, :product_category_id, :product_label_id, :product_detail)
  end
end
