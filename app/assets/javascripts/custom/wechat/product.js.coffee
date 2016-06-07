$ ->
  buyBtnMonitor()

buyBtnMonitor = () ->
  $('#buy-btn').on 'click', (e) ->
    e.preventDefault()

addToCartMonitor = () ->
