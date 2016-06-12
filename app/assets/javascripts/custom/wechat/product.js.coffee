$ ->
  buyBtnMonitor()

buyBtnMonitor = () ->
  # $('#buy-btn').on 'click', (e) ->
  #   e.preventDefault()
  #   id = $(this).data('id')
  #   prepay_id = ''
  #   $.ajax
  #     method: 'GET'
  #     url: '/wepay/unified_order',
  #     data: { id: id },
  #     dataType: 'json',
  #   .done (res) ->
  #     if res.result == 'success'
  #       prepay_id = res.data
  #     else
  #       alert(res.data)
  #   .fail ->
  #     alert('出错啦！！')
  #   .done ->
  #     chooseWXPay(prepay_id)

chooseWXPay = (prepay_id) ->
  $.ajax
    url: '/wepay/init_jspay_info',
    type: 'GET',
    data: { prepay_id: 'prepay_id=' + prepay_id },
    dataType: 'json'
  .done (res) ->
    data = res.data
    wx.chooseWXPay ({
      timestamp: data.timeStamp,
      nonceStr: data.nonceStr,
      package: data.package,
      signType: 'MD5',
      paySign: data.paySign
      success: (res) ->
        alert('支付成功！')
    })
