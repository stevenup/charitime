$ ->
#   confirmBtnMonitor()
# 
# confirmBtnMonitor = () ->
#    $('#confirm-btn').on 'click', (e) ->
#      e.preventDefault()
#      id        = $(this).data('id')
#      prepay_id = ''
# 
#      count     = $('#count').val();
#      aid       = $('#aid').val();
#      siid      = $('#siid').val();
# 
#      $.ajax
#        type: 'GET',
#        url: '/orders/create_order',
#        data: { count: count, aid: aid, siid: siid },
#      .success (res) ->
#        $info = res['data'];

#     $.ajax
#       method: 'GET'
#       url: '/wepay/unified_order',
#       data: { count: count, aid: aid, siid: siid },
#       dataType: 'json',
#     .done (res) ->
#       if res.result == 'success'
#         prepay_id = res.data
#       else
#         alert(res.data)
#     .fail ->
#       alert('出错啦！！')
#     .done ->
#       chooseWXPay(prepay_id)

#chooseWXPay = (prepay_id) ->
#  $.ajax
#    url: '/wepay/init_jspay_info',
#    type: 'GET',
#    data: { prepay_id: 'prepay_id=' + prepay_id },
#    dataType: 'json'
#  .done (res) ->
#    data = res.data
#    wx.chooseWXPay ({
#      timestamp: data.timeStamp,
#      nonceStr: data.nonceStr,
#      package: data.package,
#      signType: 'MD5',
#      paySign: data.paySign
#      success: (res) ->
#        alert('支付成功！')
#    })
