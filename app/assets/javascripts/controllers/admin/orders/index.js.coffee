using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#orders_datatable', {
    scrollX: false
  }
