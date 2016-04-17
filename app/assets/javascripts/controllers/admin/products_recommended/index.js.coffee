using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#products_recommended_datatable', {
    scrollX: false
  }
