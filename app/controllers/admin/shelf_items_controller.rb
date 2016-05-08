class Admin::ShelfItemsController < Admin::BaseController
  def index
    respond_to do |format|
      format.html
      format.json { get_rows }
    end
  end

  def list
  end

  private
  def get_rows
    dt = decode_datatables_params

    where_array = []

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

  def create_or_update(id = 0, data)
    if id == 0
      product = Product.new data
      product_id = generate_unique_id
      unless Product.find_by_product_id(product_id)
        product.product_id = product_id
      else
        product.product_id = generate_unique_id
      end
      redirect_to admin_products_path if product.save
    else
      product = Product.find(id)
      redirect_to admin_products_path if product.update_attributes data
    end
  end

  def generate_unique_id
    'C1' + SecureRandom.random_number(999999).to_s
  end

  def product_params
    params.require(:product).permit(:product_name, :thumb, :product_category_id, :product_label_id, :product_detail)
  end
end