using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#product_categories_datatable', {
    scrollX: false
  }
