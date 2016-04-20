using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#products_recommended_datatable', {
    scrollX: false
  }

$('body').delegate 'a.recommend-cancel-btn', 'click', (e) ->
  e.preventDefault()
  $.ajax({
    type: 'GET',
    url: '/admin/products/reset_recommended',
    data: {"id": this.id, "authenticity_token": "<%= form_authenticity_token %>" },
    success: (res) ->
      $info = res['data']
      console.log $info
#      window.location.reload()

  })
  $(this).parent().parent().parent().remove()