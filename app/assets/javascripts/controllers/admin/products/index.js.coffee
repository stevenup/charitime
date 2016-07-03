using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#products_datatable', {
    scrollX: false
  }