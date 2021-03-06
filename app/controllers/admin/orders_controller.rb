class Admin::OrdersController < Admin::AuthenticatedController
  include StatusesHelper

  def query
    respond_to do |format|
      format.html
      format.json { get_rows_with_query_params }
    end
  end

  def get_excel
    @orders = Order.order('created_at DESC').where(wrap_search_obj(params)).joins(:order_details).all
    render xlsx: 'generic_result', disposition: 'attachment', filename: "orders_export_#{Time.now.strftime('%Y%m%d_%H%M%S')}.xlsx"
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

  def refund_process
    @order_detail = OrderDetail.find_by_order_id(params[:id])
    if @order_detail.note
      @records = @order_detail.note.split('\n')
    end
  end

  def edit
    @order_detail = OrderDetail.find_by_order_id params[:id]
  end

  def update
    order_detail = OrderDetail.find_by_order_id(params[:order_id])
    flag = params[:flag]
    if order_detail.nil?
      render plain: 'failed to find the order.'
    elsif order_detail.order.order_status == 'REFUNDING'
      if flag == '1'
        redirect_to refund_order_path(id: params[:order_id])
      elsif flag == '0'
        note = Time.now.strftime('%Y-%m-%d %T').to_s + ': ' + params[:refusal].to_s + '\n'
        if order_detail.note.nil?
          order_detail.note = note
        else
          order_detail.note += note
        end
        redirect_to refund_orders_admin_orders_path if order_detail.order.update_attribute(:order_status, -5) and order_detail.save
      end
    else
      order_detail.delivery_company = order_detail_params[:delivery_company]
      order_detail.delivery_id      = order_detail_params[:delivery_id]
      if order_detail.save && order_detail.order.update_attribute(:logistics_status, 'DELIVERED')
        redirect_to undelivered_orders_admin_orders_path
      else
        render plain: 'failed to update logistics info.'
      end
    end
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
    where_array << 'user_id=:user_id' unless params['user_id'].blank?
    where_array << 'order_id=:order_id' unless params['order_id'].blank?
    where_array << "logistics_status=:logistics_status AND order_status = '1'" unless params['logistics_status'].blank?
    where_array << 'created_at BETWEEN :start_date AND :end_date' unless params['start_date'].blank? and params['end_date'].blank?

    placeholder_obj = {}
    %w(user_id order_id logistics_status start_date end_date).each {|k| placeholder_obj[k.to_sym] = params[k]}

    [where_array.join(' AND '), placeholder_obj]
  end

  def get_undelivered_rows
    dt = decode_datatables_params

    where_array = []
    where_array << 'orders.order_status = 1 and logistics_status != 3 and logistics_status != 4'

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
    where_array << 'orders.order_status = -4'

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