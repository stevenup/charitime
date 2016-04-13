using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#users_datatable', {
    bDestroy: true,
    scrollX: false
  }
