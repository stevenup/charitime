using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#query_orders-datatable', {
    scrollX: false
  }

  $('#query-btn').on 'click', -> dt.draw()

  $('#datetimepicker1').datetimepicker()
  $('#datetimepicker2').datetimepicker()

  # Excel download link handling
  $('#download_xls_btn').click ->
    form = $("<form method='post' action='#{$(this).data('url')}'></form>")
    $("<input name='_method' value='post' type='hidden' />").appendTo(form)
    csrfParam = $('meta[name=csrf-param]').attr('content')
    csrfToken = $('meta[name=csrf-token]').attr('content')
    $("<input name=" + csrfParam + " value=" + csrfToken + " type=hidden />").appendTo(form)
    _.forEach $('.filter-input'), (fi) ->
      $('<input/>', {
        name: $(fi).data('prop')
        val: $(fi).val()
        type: 'hidden'
      }).appendTo(form)
    form.submit()
