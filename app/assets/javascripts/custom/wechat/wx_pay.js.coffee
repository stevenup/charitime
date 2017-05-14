$ ->
  payBtnMonitor()
  refundApplyBtnMonitor()
  dedicateConfirmBtnMonitor()

dedicateConfirmBtnMonitor = () ->
  $('#dedicate-confirm-btn').on 'click', (e) ->
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
      WXPayToDedicte(prepay_id, id)

refundApplyBtnMonitor = () ->
  $('#refund-apply-btn').on 'click', (e) ->
    e.preventDefault()
    id = $(this).data('id')
    $.ajax
      method: 'GET',
      url: '/orders/apply_refund',
      data: { id: id },
      dataType: 'json',
    .done (res) ->
      if res.result == 'success'
        alert('申请退款发送成功！')
        $('#refund-apply-btn').display('none')
      else
        alert(res.data)

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
      chooseWXPay(prepay_id, id)

chooseWXPay = (prepay_id, id) ->
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
#          alert('支付成功！')
          $.ajax
            type: 'GET',
            url: '/orders/add_gyb_payment_record',
            data: { id: id },
            success: (res) ->
              window.location.href = "http://goodbuy.nonprofit.cn/orders?status=0" if res.status == 'success'
        else
          alert(res.errMsg)
      cancel: () ->
#        alert('支付取消')
    })

WXPayToDedicte = (prepay_id, id) ->
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
#          alert('支付成功！')
          window.location.href = "http://goodbuy.nonprofit.cn/supports/detail?id=" + id
        else
          alert(res.errMsg)
      cancel: () ->
#        alert('支付取消')
    })
