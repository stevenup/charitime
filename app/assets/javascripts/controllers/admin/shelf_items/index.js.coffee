using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#shelf_items_datatable', {
    scrollX: false
  }
