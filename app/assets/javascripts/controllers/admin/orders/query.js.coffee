using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#query_orders-datatable', {
    scrollX: false
  }

  $('#query-btn').on 'click', -> dt.draw()

  $('#datetimepicker1').datetimepicker()
  $('#datetimepicker2').datetimepicker()