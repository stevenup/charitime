class Admin::ProductLabelsController < Admin::BaseController
  def index
    respond_to do |format|
      format.html
      format.json { get_rows }
    end
  end

  def new
    @product_label = ProductLabel.new
  end

  def edit
    @product_label = ProductLabel.find params[:id]
  end

  def create
    create_or_update product_label_params
  end

  def update
    create_or_update params[:id], product_label_params
  end

  def destroy
    product_label = ProductLabel.find params[:id]
    redirect_to admin_product_labels_path if product_label.destroy
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

    @total_rows = ProductLabel.count(search_obj)
    @rows = ProductLabel.page(dt[:page]).per(dt[:per_page])
                .includes(search_obj[:include])
                .joins(search_obj[:joins])
                .order(search_obj[:order])
                .where(search_obj[:conditions])
  end

  def create_or_update(id = 0, data)
    if id == 0
      product_label = ProductLabel.new data
      redirect_to admin_product_labels_path if product_label.save
    else
      product_label = ProductLabel.find(id)
      redirect_to admin_product_labels_path if product_label.update_attributes data
    end
  end

  def product_label_params
    params.require(:product_label).permit(:product_label_name )
  end
end