class Admin::ShelfItemsController < Admin::BaseController
  def index
    respond_to do |format|
      format.html
      format.json { get_rows params[:flag] }
    end
  end

  def list
  end

  def on_shelf
    flag = params[:flag]
    shelf_item = ShelfItem.new
    shelf_item.is_on_shelf = flag
    shelf_item.save
  end

  private
  def get_rows flag
    dt = decode_datatables_params

    if flag == '1'
      where_array = []
      where_array << "products.recommended = '1'"

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

  end

  def create_or_update(id = 0, data)
    if id == 0
      product = Product.new data
      redirect_to admin_products_path if product.save
    else
      product = Product.find(id)
      redirect_to admin_products_path if product.update_attributes data
    end
  end

  def product_params
    params.require(:product).permit(:product_name, :thumb, :product_category_id, :product_label_id, :product_detail)
  end
end