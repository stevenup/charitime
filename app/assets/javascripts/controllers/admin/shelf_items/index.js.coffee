using Utils.Datatables, (ctx) ->
  dt = ctx.newForAjax '#shelf_items_datatable', {
    scrollX: false
  }

$('body').delegate 'a.on-shelf-btn', 'click', (e) ->
  e.preventDefault()
  $.ajax({
    type: 'GET',
    url: '/admin/shelf_items/on_shelf',
    data: {"id": this.id, "flag": "1", "authenticity_token": "<%= form_authenticity_token %>" },
    success: (res) ->
      $info = res['data']
      console.log $info
#      window.location.reload()

  })
#  $(this).parent().parent().parent().remove()

$('.nav-tabs li').on 'click', ->
  $.ajax({
    type: 'GET',
    url: '/admin/shelf_items',
    data: {"flag": "1", "authenticity_token": "<%= form_authenticity_token %>" },
    success: (res) ->
      $info = res['data']
      console.log $info
#      window.location.reload()

  })