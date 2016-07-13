using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#undelivered_orders_datatable', {
    scrollX: false
  }