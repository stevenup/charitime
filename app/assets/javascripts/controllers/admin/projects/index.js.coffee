using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#projects_datatable', {
    scrollX: false
  }
