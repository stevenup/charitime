using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#query_orders_datatable', {
  scrollX: false,
  order: [[ 7, 'desc' ]]
  }
  $('#query-btn').on 'click', -> dt.draw()

  $('#datetimepicker1').datetimepicker()
  $('#datetimepicker2').datetimepicker()