using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#recommended_projects_datatable', {
    scrollX: false
  }
