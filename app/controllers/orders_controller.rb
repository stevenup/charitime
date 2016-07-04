class OrdersController < BaseController
  def index
    if status = params[:status]
      @orders = Order.where("user_id = ? and (order_status = ? or logistics_status != ?)", '1', '0', '2').order(created_at: :desc) if status == '0'
      @orders = Order.where("order_status = ? or logistics_status = ?", '1', '2').order(created_at: :desc) if status == '1'
    else
      @orders = Order.where("user_id = ?", '1').order(created_at: :desc)
    end
  end

  def show
    order_id = params[:id]
    @order_detail = OrderDetail.find_by_order_id order_id
  end

  def pay
    order_id = params[:id]
    @order_detail = OrderDetail.find_by_order_id order_id
  end

  def apply_refund
    order_id = params[:id]
    order = Order.find_by_order_id order_id
    order.update_attribute :order_status, -3
    redirect_to :action => 'show', :id => order_id
  end

  def cancel_order
    id = params[:id]
    order = Order.find_by_order_id id
    order.update_attribute :order_status, 2
    redirect_to :action => 'show', :id => id
  end

  def create
    count = params[:count]
    aid   = params[:aid]
    siid  = params[:siid]
    shelf_item  = ShelfItem.find_by_id siid
    address     = Address.find_by_id aid
    order_detail_params = shelf_item.attributes.merge(address.attributes)
                              .except("id","project_id", "product_category_id", "product_label_id",
                                      "product_detail", "stock", "sales", "is_on_shelf", "recommended",
                                      "created_at", "updated_at", "user_id", "default")
    # generate a unique order_id to relate Order with OrderDetail model
    order_id      = 1000000000 + SecureRandom.random_number(999999999)
    out_refund_no = 1000000000 + SecureRandom.random_number(999999999)
    order_detail_params[:count]         = count.to_i
    order_detail_params[:order_id]      = order_id
    order_detail_params[:out_refund_no] = out_refund_no
    order_detail = OrderDetail.new order_detail_params
    order_detail.save
    order = Order.new
    order[:order_id]     = order_id
    order[:user_id]      = '1'
    total_price          = order_detail_params[:count] * (shelf_item.price - shelf_item.gyb_discount)
    order[:total_price]  = total_price
    order[:order_status] = '0'
    order.save
    redirect_to :action => 'pay', :id => order_id
  end

  def change_order_status
    id = params[:id]
    order = Order.find_by :order_id => id
    order.update_attribute :order_status, 1
    render json: { status: 'success' }
  end
end
