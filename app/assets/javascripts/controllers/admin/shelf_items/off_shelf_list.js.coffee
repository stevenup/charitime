using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#off_shelf_items_datatable', {
    scrollX: false
  }

$modal = $('#popup-container')
$('.table-responsive').delegate '.on-shelf-btn', 'click', (e) ->
  e.preventDefault()
  $('body').modalmanager('loading')
  url = Routes.new_admin_shelf_item_path(id: $(this).data('id'))
  Routes.admin_shelf_items_path(id: $(this).data('id'))
  $modal.load url, ->
    $modal.modal({keyboard: false, backdrop: 'static', attentionAnimation: false})

$('#popup-container').delegate '#save-item-btn', 'click', () ->
  $('#shelf-item-form').find('form')
  .on('ajax:success', (event, data) ->
    if data.meta.code is 200
      $modal.modal('hide')
      dt.draw()
      showInfo "成功保存城市"
  ).submit()