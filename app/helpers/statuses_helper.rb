module StatusesHelper
  def display_status(order_status, logistics_status)
    if order_status == '1'
      if logistics_status == '0'
        return '待发货'
      elsif logistics_status == '3'
        return '已发货'
      elsif logistics_status == '4'
        return '已完成'
      else
        return 'NaN'
      end
    else
      return '退款驳回'    if order_status == '-5'
      return '退款处理中'  if order_status == '-4'
      return '已退款'      if order_status == '-3'
      return '支付取消'    if order_status == '-2'
      return '支付失败'    if order_status == '-1'
      return '未支付'      if order_status == '0'
      'NaN'
    end
  end
end