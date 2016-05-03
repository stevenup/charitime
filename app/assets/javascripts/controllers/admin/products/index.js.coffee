using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#products_datatable', {
    scrollX: false
  }

$('body').delegate 'a.recommend-btn', 'click', (e) ->
  e.preventDefault()
  $.ajax({
    type: 'GET',
    url: '/admin/products/set_recommended',
    data: {"id": this.id, "authenticity_token": "<%= form_authenticity_token %>" },
    success: (res) ->
      $info = res['data']
      console.log $info
  })
  document.getElementById(this.id).innerHTML = "已推荐"

