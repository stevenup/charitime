class Admin::OrdersController < Admin::BaseController
  def index
    respond_to do |format|
      format.html
      format.json { get_rows }
    end
  end

  def edit
    @order_detail = OrderDetail.find_by_order_id params[:id]
  end

  def update
    order_detail = OrderDetail.find_by_order_id(params[:id])
    redirect_to admin_orders_path if order_detail.update_attributes order_detail_params
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

    @total_rows = Order.count(search_obj)
    @rows = Order.page(dt[:page]).per(dt[:per_page])
                .includes(search_obj[:include])
                .joins(search_obj[:joins])
                .order(search_obj[:order])
                .where(search_obj[:conditions])
  end

  def order_detail_params
    params.require(:order_detail).permit(:delivery_company, :delivery_id)
  end
end