using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#refund_orders_datatable', {
    scrollX: false
  }