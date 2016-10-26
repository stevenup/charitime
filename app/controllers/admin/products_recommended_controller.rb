class Admin::ProductsRecommendedController < Admin::AuthenticatedController
  def index
    respond_to do |format|
      format.html
      format.json { get_rows }
    end
  end

  private
  def get_rows
    dt = decode_datatables_params

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

  def product_params
    params.require(:product).permit(:product_id, :project_id, :product_name, :product_category_id, :product_label_id, :product_detail)
  end
end