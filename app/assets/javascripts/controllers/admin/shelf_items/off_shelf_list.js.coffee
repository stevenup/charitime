using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#off_shelf_items_datatable', {
    scrollX: false
  }

$modal = $('#popup-container')
$('.table-responsive').delegate '.on-shelf-btn', 'click', (e) ->
  e.preventDefault()
  $('body').modalmanager('loading')
  url = Routes.edit_admin_shelf_item_path(id: $(this).data('id'))
  $modal.load url, ->
    $modal.modal({keyboard: false, backdrop: 'static', attentionAnimation: false})
