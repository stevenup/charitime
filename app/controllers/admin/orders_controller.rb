class Admin::OrdersController < Admin::BaseController
  include FormatsHelper

  def query
    respond_to do |format|
      format.html
      format.json { get_rows_with_query_params }
    end
  end

  def get_excel
    puts '>>>>>>>>>>>>>> came here!'
    @orders = Order.order('created_at DESC').where(wrap_search_obj(params))
    render xlsx: "get_excel", disposition: "attachment", filename: "orders_export_#{Time.now.strftime("%Y%m%d_%H%M%S")}.xlsx"
  end

  def undelivered_orders
    respond_to do |format|
      format.html
      format.json { get_undelivered_rows }
    end
  end

  def refund_orders
    respond_to do |format|
      format.html
      format.json { get_refund_orders_rows }
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

  def get_rows_with_query_params
    dt = decode_datatables_params

    search_obj = {
      :include => [],
      :joins => [],
      :order => dt[:sort_statement],
      :conditions => wrap_search_obj(params)
    }

    @total_rows = Order.joins(search_obj[:joins]).where(search_obj[:conditions]).count()
    @rows = Order.page(dt[:page]).per(dt[:per_page])
              .includes(search_obj[:include])
              .joins(search_obj[:joins])
              .order(search_obj[:order])
              .where(search_obj[:conditions])
  end

  def wrap_search_obj(params)
    where_array = []
    where_array << "user_id=:user_id" unless params['user_id'].blank?
    where_array << "order_id=:order_id" unless params['order_id'].blank?
    where_array << "order_status=:order_status" unless params['order_status'].blank?
    where_array << "created_at BETWEEN :start_date AND :end_date" unless params['start_date'].blank? and params['end_date'].blank?

    placeholder_obj = {}
    %w(user_id order_id order_status start_date end_date).each {|k| placeholder_obj[k.to_sym] = params[k]}

    [where_array.join(' AND '), placeholder_obj]
  end

  def get_undelivered_rows
    dt = decode_datatables_params

    where_array = []
    where_array << 'orders.order_status = 1 and orders.logistics_status = 0'

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

  def get_refund_orders_rows
    dt = decode_datatables_params

    where_array = []
    where_array << 'orders.order_status = -3'

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

  def order_query_params
    params.require(:order).permit(:user_id, :order_id, :order_status, :start_date, :end_date)
  end
end