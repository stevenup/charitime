$ ->
  buyBtnMonitor()

buyBtnMonitor = () ->
  $('#buy-btn').on 'click', (e) ->
    e.preventDefault()
    id = $(this).data('id')
    $.ajax ({
      method: 'GET'
      url: '/wepay/unified_order',
      data: { id: id },
      dataType: 'json',
      success: () ->
        alert('unified_order success')
    })

addToCartMonitor = () ->
