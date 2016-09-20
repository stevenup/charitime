module FormatsHelper

  # Format date time for API, it will be formatted as following:
  #   2012/03/05 12:03:45 => 20120305120345
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
end