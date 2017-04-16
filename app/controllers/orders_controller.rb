class OrdersController < BaseController
  before_filter :check_duplicate_order, only: [:create]
  include StatusesHelper
  include UrlHelper

  def index
    status = params[:status]
    if status == '0'
      @title  = '未完成订单'
      @orders = Order.where('user_id = ? and (order_status = ? or order_status = ?) and logistics_status != ?', current_user.id.to_s, 0, 1, 4).order('created_at DESC')
    elsif status == '1'
      @title  = '已完成订单'
      @orders = Order.where('user_id = ? and logistics_status = ?', current_user.id.to_s, 4).order('created_at DESC')
    elsif status == '2'
      @title  = '退款/售后订单'
      @orders = Order.where('user_id = ? and (order_status = ? or order_status = ? or order_status = ?)', current_user.id.to_s, -3, -4, -5).order('created_at DESC')
    else
      @title  = '所有订单'
      @orders = Order.where('user_id = ?', current_user.id.to_s).order('created_at DESC')
    end
  end

  def pay
    order_id      = params[:id]
    @order_detail = OrderDetail.find_by_order_id order_id
    Address.convert_addr(@order_detail)
  end

  def show
    order_id      = params[:id]
    @order_detail = OrderDetail.find_by_order_id order_id
    Address.convert_addr(@order_detail)
    if @order_detail.note
      @records = @order_detail.note.split('\n')
    end
  end

  def apply_refund
    order_id = params[:id]
    order    = Order.find_by_order_id order_id
    order.update_attribute(:order_status, -4)
    redirect_to orders_path :id => order_id
  end

  def cancel_order
    id    = params[:id]
    order = Order.find_by_order_id id
    order.update_attribute(:order_status, -2)
    redirect_to :action => 'show', :id => id
  end

  def confirm_complete
    id    = params[:id]
    order = Order.find_by_order_id id
    order.update_attribute(:logistics_status, 4)
    redirect_to :action => 'show', :id => id
  end

  def create
    count               = params[:count]
    aid                 = params[:aid]
    siid                = params[:siid]
    remark              = params[:remark]
    shelf_item          = ShelfItem.find_by_id siid
    address             = Address.find_by_id aid
    order_detail_params = shelf_item.attributes.merge(address.attributes)
                              .except('id','project_id', 'product_id', 'product_category_id', 'product_label_id',
                                      'product_detail', 'stock', 'sales', 'is_on_shelf', 'recommended',
                                      'created_at', 'updated_at', 'user_id', 'default', 'category', 'label')

    # Generate a unique order_id to relate Order with OrderDetail model
    order_id                             = 10000000000 + SecureRandom.random_number(9999999999)
    out_refund_no                        = order_id
    order_detail_params[:shelf_item_id]  = siid
    order_detail_params[:count]          = count.to_i
    order_detail_params[:order_id]       = order_id
    order_detail_params[:out_refund_no]  = out_refund_no
    order_detail_params[:remark]         = remark

    # Determine whether the user has enough gybs for discount and calculate the total price.
    if current_user.gyb < shelf_item.gyb_discount
      order_detail_params[:gyb_discount] = 0
      total_price                        = (order_detail_params[:count] * shelf_item.price) - order_detail_params[:gyb_discount] / 100
    else
      order_detail_params[:gyb_discount] = shelf_item.gyb_discount
      total_price                        = (order_detail_params[:count] * shelf_item.price) - order_detail_params[:gyb_discount] / 100
    end

    order_detail                         = OrderDetail.new order_detail_params
    order_detail.save

    order                = Order.new
    order[:order_id]     = order_id
    order[:user_id]      = current_user.id.to_s
    order[:total_price]  = total_price
    order[:order_status] = '0'
    order.save
    redirect_to :action => 'pay', :id => order_id
  end

  def add_gyb_payment_record
    id                     = params[:id]
    order_detail           = OrderDetail.find_by :order_id => id

    if order_detail.gyb_discount > 0
      gyb_payment          = GybPayment.new
      gyb_payment.user_id  = current_user.id.to_s
      gyb_payment.order_id = order_detail.order_id
      gyb_payment.save

      current_user.gyb     -= order_detail.gyb_discount
      current_user.save
    end
    render json: { status: 'success' }
  end

  def get_logistics_info
    req_data = { "OrderCode": "", "ShipperCode": "SF", "LogisticCode": "118650888018" }
    e_business_id = Settings.kdniao.EBusinessID
    req_type = '1002'
    data_sign = Modules::Kdniao.sign_data(req_data)
    api_url = Settings.kdniao.APIUrl
    url = "#{api_url}?RequestData=#{URI.encode_www_form(req_data)}&EBusinessId=#{e_business_id}&RequestType=#{req_type}&DataSign=#{data_sign}&DataType=2-json"
    puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    puts url
    clnt = HTTPClient.new
    clnt.head
    info = HTTPClient.post url
    puts 'L:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    puts info.body
  end

  private
  def check_duplicate_order
    count  = params[:count]
    aid    = params[:aid]
    siid   = params[:siid]
    remark = params[:remark]

    addr         = Address.find_by_id(aid)
    order_detail = OrderDetail.find_by('shelf_item_id = ? and count = ? and remark = ? and province = ? and city = ? and district = ? and detail_address = ?',
                                          siid, count, remark, addr.province, addr.city, addr.district, addr.detail_address)
    if order_detail and order_detail.order.order_status == 'UNPAID'
      flash[:type]    = 'alert'
      flash[:message] = '您有重复的未支付订单, 请前往 我的 -> 未完成订单 进行支付。'
      redirect_to shelf_item_path(params[:siid])
    end
    # render :nothing => true, :status => 301
  end
end
