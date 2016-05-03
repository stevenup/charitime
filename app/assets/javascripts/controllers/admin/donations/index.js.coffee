using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#donations_datatable', {
    scrollX: false
  }
