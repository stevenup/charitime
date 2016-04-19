using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#products_datatable', {
    scrollX: false
  }

$('body').delegate 'a', 'click', (e) ->
  e.preventDefault()
  alert('tttt')
  $.ajax({
    type: 'GET',
    url: '/admin/products/set_recommended',
    data: {id: this.id},
    success: (res) ->
      $info = res['data']
  })
