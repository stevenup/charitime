module FormatsHelper
  def format_datetime(date)
    date.strftime("%Y%m%d%H%M%S") if date
  end

  def format_date_compact(date)
    date.strftime("%Y%m%d") if date
  end

  def format_datetime2(date)
    date.strftime("%Y-%m-%d %H:%M:%S") if date
  end

  def format_date(date)
    date.strftime("%Y-%m-%d") if date
  end

  def format_date_cn(date)
    date.strftime("%Y年%m月%d日") if date
  end

  def format_datetime_cn_chort(date)
    date.strftime("%m月%d日 %H:%M") if date
  end

  def format_money(val)
    "%.2f" % val.round(2) unless val.blank?
  end

  def format_number(val, decimal_point, always_show_decimal)
    if always_show_decimal
      "%.#{decimal_point}f" % val.round(decimal_point)
    else
      "%g" % val.round(decimal_point)
    end
  end

  def partially_hidden(str)
    length = str.length
    str[(length/2 - 2)..(length/2 + 1)] = '****'
    str
  end

  def display_status(str)
    '退款驳回'    if str == '-5'
    '退款处理中'  if str == '-4'
    '已退款'      if str == '-3'
    '支付取消'    if str == '-2'
    '支付失败'    if str == '-1'
    '未支付'      if str == '0'
    '已支付'      if str == '1'
    '未发货'      if str == '2'
    '已发货'      if str == '3'
    '已完成'      if str == '4'
  end
end