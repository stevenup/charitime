class Admin::ProductCategoriesController < Admin::BaseController
  def index
    respond_to do |format|
      format.html
      format.json { get_rows }
    end
  end

  def new
    @product_category = ProductCategory.new
  end

  def edit
    @product_category = ProductCategory.find params[:id]
  end

  def create
    create_or_update product_category_params
  end

  def update
    create_or_update params[:id], product_category_params
  end

  def destroy
    product_category = ProductCategory.find params[:id]
    redirect_to admin_product_categories_path if product_category.destroy
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

    @total_rows = ProductCategory.count(search_obj)
    @rows = ProductCategory.page(dt[:page]).per(dt[:per_page])
                .includes(search_obj[:include])
                .joins(search_obj[:joins])
                .order(search_obj[:order])
                .where(search_obj[:conditions])
  end

  def create_or_update(id = 0, data)
    if id == 0
      product_category = ProductCategory.new data
      redirect_to admin_product_categories_path if product_category.save
    else
      product_category = ProductCategory.find(id)
      redirect_to admin_product_categories_path if product_category.update_attributes data
    end
  end

  def product_category_params
    params.require(:product_category).permit(:product_category_name )
  end
end