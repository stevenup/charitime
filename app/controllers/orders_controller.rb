class OrdersController < BaseController
  def index
  end

  def pay
    order_id = params[:order_id]
    @order_detail = OrderDetail.find_by_order_id order_id
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
                                      "thumb", "created_at", "updated_at", "user_id", "default")
    # generate a unique order_id to relate Order with OrderDetail model
    order_id = 1000000000 + SecureRandom.random_number(999999999)
    order_detail_params[:count] = count.to_i
    order_detail_params[:order_id] = order_id
    order_detail = OrderDetail.new order_detail_params
    order_detail.save
    order = Order.new
    order[:order_id] = order_id
    order[:user_id]  = current_user.id
    total_price         = order_detail_params[:count] * (shelf_item.price - shelf_item.gyb_discount)
    order[:total_price] = total_price
    order[:status]      = '0'    # 0 stands for 待付款， 1 已付款待发货，2 已发货待签收，3 已完成
    # transid
    order.save
    redirect_to :action => 'pay', :order_id => order_id
  end

  def change_order_status
    id = params[:id]
    order = Order.find_by :order_id => id
    order.update_attribute :order_status, 1
    render json: { status: 'success' }
  end
end
