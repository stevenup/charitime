root = exports ? this
$ ->
  $(document)
    .ajaxComplete(ajaxCompleteHandler)
    .ajaxStart(ajaxStartHandler)
    # .ajaxError(ajaxErrorHandler)

ajaxCompleteHandler = (event, jqXHR, ajaxSettings)->
  reloadAfterLoadAndAjax()
  UtilsCommon.globalSpin(false)

ajaxStartHandler = -> UtilsCommon.globalSpin(true)

ajaxErrorHandler = (event, jqXHR, ajaxSettings, thrownError) ->
  msg = "服务器数据请求错误"
  response = null
  try
    response = $.parseJSON(jqXHR.responseText) if jqXHR.responseText?
  # We have to avoid abort and cancelled error due to the limitation of remotipart: ref: https://github.com/JangoSteve/remotipart/issues/13
  unless !response? && (thrownError is 'abort' || thrownError is 'canceled')
    if (response? && response.meta.errors? && ($.isArray(response.meta.errors) && response.meta.errors.length > 0))
      msg = response.errors[0]
    promptMsg(msg, 'error') unless response? && response.meta.code == 200

# 为弹出式AJAX表单组织需要的属性
# params
#   * urlRoot: 基础路径，基本上为controller根地址
#   * dataId: 数据Id，为0时表示新建记录
# return: 返回一个对象，包含有以下属性
#   * urlGet: 用来获取数据信息的URL
#   * formUrl: 用来设置AJAX表单的Action URL
#   * formMethod: AJAX表单提交的方法，PUT为更新，POST为新建
root.formWrapper = (urlRoot, dataId) ->
  if dataId == 0
    { urlGet: "#{urlRoot}/new.json", formUrl: "#{urlRoot}.json", formMethod: 'post', title: '新增' }
  else
    { urlGet: "#{urlRoot}/#{dataId}.json", formUrl: "#{urlRoot}/#{dataId}.json", formMethod: 'put', title: '编辑' }

root.wrapAjaxForm = (formSelector, wrapper) ->
  $(formSelector).attr('action', wrapper.formUrl)
  $("#{formSelector} input[name=_method]").val(wrapper.formMethod)
  # TODO: 看来直接设置form的method，在引入remotipart后，表单有文件附加的时候，在编辑的情况下，AJAX会以GET而不是PUT的方式提交表单，会有错误，
  # 必须在表单重强制加入:method => :put来确保表单中会被加入_method的input字段
  # $(formSelector).attr('method', wrapper.formMethod)

# Things need to be done after page load or ajax load
root.reloadAfterLoadAndAjax = () ->
  # 时间戳美化
  $("abbr.timeago").timeago()
  # tooltip initialization
  $('[data-toggle="tooltip"]').tooltip({ container: 'body' })
