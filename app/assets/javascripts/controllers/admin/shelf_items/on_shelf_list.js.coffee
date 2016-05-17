using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#on_shelf_list_datatable', {
    scrollX: false
  }


$('body').delegate 'a.off-shelf-btn', 'click', (e) ->
  e.preventDefault()
  $.ajax({
    type: 'GET',
    url: '/admin/shelf_items/pull_off_shelf',
    data: {"id": this.id, "flag": "0", "authenticity_token": "<%= form_authenticity_token %>"},
    success: (res) ->
      $info = res['data']
      console.log $info
# window.location.reload()
  })
  $(this).parent().parent().parent().remove()
