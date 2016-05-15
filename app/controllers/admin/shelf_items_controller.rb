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
  
  def new
    @shelf_item = ShelfItem.new
    @product = Product.find_by :id => params[:id]       # product info will be displayed in the modal
    render 'form', :layout =>  'bootstrap_modal', locals: { url: admin_shelf_items_path }
  end

  def create
    # product = Product.find_by :id => params[:id]
    # merged_params = product.attributes.merge shelf_item_params
    create_or_update 0, shelf_item_params
  end

  def update
    product = Product.find_by :id => params[:id]
    merged_params = product.attributes.merge shelf_item_params
    create_or_update params[:id], merged_params
  end

  def edit
    @shelf_item = ShelfItem.new
    @product = Product.find_by :id => params[:id]       # product info will be displayed in the modal
    render 'form', :layout =>  'bootstrap_modal'
  end

  def put_on_shelf
    flag = '1'
    id = params[:id]
    product = Product.find_by :id => id
    @shelf_item = ShelfItem.new

    shelf_item.is_on_shelf = flag
    product.is_on_shelf = flag
    product.save
    @shelf_item.save

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

  def create_or_update(id, form_data, template = 'form')
    if id == 0
      product = Product.find_by :id => params[:id]
      merged_params = product.attributes.merge form_data
      @shelf_item = ShelfItem.new merged_params
      result = @shelf_item.save
    else
      @shelf_item = ShelfItem.find(id)
      result = @shelf_item.update_attributes(form_data)
    end
    response_after_save_json result, @shelf_item
  end

  def shelf_item_params
    params.require(:shelf_item).permit(:price, :gyb_discount, :stock)
  end
end
