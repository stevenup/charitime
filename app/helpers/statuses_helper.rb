module StatusesHelper
  def transform_status(order_status, logistics_status)
    if order_status == 'PAID'
      if logistics_status == 'DELIVERED'
        return '已发货'
      elsif logistics_status == 'COMPLETED'
        return '已完成'
      else
        return '待发货'
      end
    else
      return '退款驳回'    if order_status == 'REFUND_REJECTED'
      return '退款处理中'  if order_status == 'REFUNDING'
      return '已退款'      if order_status == 'REFUNDED'
      return '支付取消'    if order_status == 'CANCELED'
      return '支付失败'    if order_status == 'FAILED'
      return '未支付'      if order_status == 'UNPAID'
      'NaN'
    end
  end
end