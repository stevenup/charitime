using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#off_shelf_items_datatable', {
    scrollX: false
  }

  $modal = $('#myModal')
  $('.table-responsive').delegate '.on-shelf-btn', 'click', (e) ->
    e.preventDefault()
    $('body').modalmanager('loading')
    url = Routes.edit_admin_shelf_item_path(id: $(this).data('id'))
    $modal.load url, ->
      $modal.modal({keyboard: false, backdrop: 'static', attentionAnimation: false})



#  $.ajax({
#    type: 'GET',
#    url: '/admin/shelf_items/put_on_shelf',
#    data: {"id": this.id, "flag": "1", "authenticity_token": "<%#= form_authenticity_token %>"},
#    success: (res) ->
#      $info = res['data']
#      console.log $info
##      window.location.reload()
#
#  });
#  $(this).parent().parent().parent().remove()