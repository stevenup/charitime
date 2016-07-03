$ ->
  payBtnMonitor()
  refundBtnMonitor()

refundBtnMonitor = () ->
  $('#refund-btn').on 'click', (e) ->
    e.preventDefault()
    id = $(this).data('id')
    $.ajax
      method: 'GET',
      url: '/wepay/refund_order',
      data: { id: id },
      dataType: 'json',
    .done (res) ->
      if res.result == 'success'
        alert('申请退款成功！')
        $('#refund-btn').display('none')
      else
        alert(res.data)
    .fail ->
      alert('出错啦！')

payBtnMonitor = () ->
  $('#pay-btn').on 'click', (e) ->
    e.preventDefault()
    id = $(this).data('id')
    prepay_id = ''

    $.ajax
      method: 'GET'
      url: '/wepay/unified_order',
      data: { id: id },
      dataType: 'json',
    .done (res) ->
      if res.result == 'success'
        prepay_id = res.data
      else
        alert(res.data)
    .fail ->
      alert('出错啦！！')
    .done ->
      chooseWXPay(prepay_id)

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
        if res.errMsg == "chooseWXPay:ok"
          alert('支付成功！')
          $.ajax
            type: 'GET',
            url: '/orders/change_order_status',
            data: {id: $(this).data('id')},
            success: (res) ->
              if res.status == 'success'
                alert('修改订单状态成功！')
#                window.location = Routes.order_path(id: id)   ### hope there is a redirect to the orders/show view
        else
          alert(res.errMsg)
      cancel: () ->
        alert('支付取消')
    })
