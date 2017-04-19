class Admin::ProductsController < Admin::AuthenticatedController
  def index
    respond_to do |format|
      format.html
      format.json { get_rows }
    end
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find params[:id]
  end

  def create
    create_or_update product_params
  end

  def update
    create_or_update params[:id], product_params
  end

  def destroy
    product = Product.find params[:id]
    redirect_to admin_products_path if product.destroy
  end

  def preview
    id = params[:id]
    @product = Product.find_by_id(id)
    render layout: 'application'
  end

  def set_recommended
    id = params[:id]
    product = Product.find_by_id(id)

    if product && product.recommended != '1'
      product.recommended = '1'
      product.save
      render json: {data: 'success'}
    else
      render json: {data: 'recommended has already been set'}
    end

  end

  def reset_recommended
    id = params[:id]
    product = Product.find_by_id(id)
    product.recommended = '0'
    product.save

    render json: {data: 'success'}
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
      product.product_id = generate_unique_id
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
    params.require(:product).permit(:product_name, :thumb, :category, :product_detail)
  end
end
