using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#recommended_list_datatable', {
    scrollX: false
  }
