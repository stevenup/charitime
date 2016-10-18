class OrdersController < BaseController
  def index
    status = params[:status]
    if status == '0'
      @orders = Order.where("user_id = ? and logistics_status != ?", current_user.id, 4).order("created_at DESC")
    elsif status == '1'
      @orders = Order.where("user_id = ? and logistics_status = ?", current_user.id, 4).order("created_at DESC")
    else
      @orders = Order.where("user_id = ?", current_user.id).order("created_at DESC")
    end
  end

  def pay
    order_id = params[:id]
    @order_detail = OrderDetail.find_by_order_id order_id
  end

  def show
    order_id = params[:id]
    @order_detail = OrderDetail.find_by_order_id order_id
  end

  def apply_refund
    order_id = params[:id]
    order = Order.find_by_order_id order_id
    order.update_attribute(:order_status, -4)
    redirect_to orders_path :id => order_id
  end

  def cancel_order
    id = params[:id]
    order = Order.find_by_order_id id
    order.update_attribute(:order_status, -2)
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
                                      "created_at", "updated_at", "user_id", "default", "category", "label")
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
    order[:user_id]      = current_user.id
    total_price          = order_detail_params[:count] * (shelf_item.price - shelf_item.gyb_discount)
    order[:total_price]  = total_price
    order[:order_status] = '0'
    order.save
    redirect_to :action => 'pay', :id => order_id
  end

  def change_order_status
    id = params[:id]
    order = Order.find_by :order_id => id
    order.update_attribute(:order_status, 1)
    render json: { status: 'success' }
  end
end
