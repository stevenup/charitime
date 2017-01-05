class Admin::HomeController < Admin::AuthenticatedController
  def index
    @num_undelivered_orders = Order.where('order_status = ?', 1).count
    @num_refunding_orders   = Order.where('order_status = ?', -4).count
    @sales_volume           = Order.where('order_status = ?', 1).sum(:total_price)
    @num_new_users          = User.where('created_at between ? and ?', Time.new.change(hour: 0), Time.now).count
    @num_supports           = Support.where('status = ?', '1').count
  end
end
