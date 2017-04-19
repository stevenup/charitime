window.UtilsCommon =
  # Get integer from a string value, return 0 if it is NaN
  getInteger: (value) ->
    value = 0 unless $.isNumeric(value)
    parseInt value

  # Datatable中boolean类型字段的渲染器，对于true显示一个打钩图标，否则不显示
  dtBooleanRender: (o) ->
    if o.aData[o.mDataProp] then "<i class='fa fa-check'></i>" else ""

  # 为datatable中的toggle列准备template
  dtTogglerTemplate: (property, on_label, off_label, url) ->
    colContentTemp = _.template """
    <div class='btn-group'>
      <a class='btn dropdown-toggle' data-toggle='dropdown' href='javascript:void(0);'>
        <i class='<% if(#{property}) {%>fa fa-check<%} else {%>fa fa-times <%}%>'></i>
        <span class='caret'></span>
      </a>
      <ul class='dropdown-menu' style='min-width: 80px;'>
        <% if(#{property}) {%>
          <li><a href='javascript:void(0);' class='toggle_#{property} off' data-url='#{url}' data-prop='#{property}'><i class='fa fa-times'></i> #{off_label}</a></li>
        <%} else {%>
          <li><a href='javascript:void(0);' class='toggle_#{property} on' data-url='#{url}' data-prop='#{property}'><i class='fa fa-check'></i> #{on_label}</a></li>
        <%}%>
      </ul>
    </div>
    """

  resetFilterForm: (container) ->
    $(container).find('form')[0].reset()
    $(container).find('.chzn-select').trigger 'change'

  redirect: (target) ->
    window.navigate target

  escapeHtmlString: (str) -> str.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#39;')

  globalSpin: (run = true) ->
    if run
      $('#loading-spinner').show()
    else
      $('#loading-spinner').hide()

  # Block full page with message
  blockFull: (msg) ->
    $.blockUI
      message: msg || '<i class="fa fa-spinner fa-spin"></i> 后台处理中......'
      baseZ: 1100
      css:
        border: 'none'
        padding: '15px'
        backgroundColor: '#000'
        '-webkit-border-radius': '10px'
        '-moz-border-radius': '10px'
        opacity: .5
        color: '#fff'
        'font-size': '22px'

  # Block element with message
  block: (obj, msg) ->
    obj.block
      message:  "<i class='fa fa-spinner fa-spin'></i> #{msg || '后台处理中......'}"
      css:
        border: 'none'
        padding: '15px'
        backgroundColor: '#000'
        '-webkit-border-radius': '5px'
        '-moz-border-radius': '5px'
        opacity: .5
        color: '#fff'
        'font-size': '14px'

  # Releaese the full block
  unblockFull: () ->  $.unblockUI()

# Output debug info
window.debug = (msg) -> console.debug "DEBUG>>> #{msg}"
