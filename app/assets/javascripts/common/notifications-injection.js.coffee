# Growl the flash messages sent from rails
window.growlFlashMessages = ->
  if($(".flash p").size())
    type = $(".flash p").parent().attr("data-alert")
    promptMsg $(".flash p").text(), type

# Prompt a message with type and selected type
window.promptMsg = (message, type) ->
  if type is "info"
    alertify.success message
  else
    alertify.error message

window.showInfo = (message) -> alertify.closeLogOnClick(true).delay(10000).success message
window.showError = (message) -> alertify.closeLogOnClick(true).delay(0).error message
window.showAjaxError = (jqXHR, textStatus, errorThrown) ->
  try
    showError "服务器请求出错：#{jqXHR.responseJSON.meta.message}"
  catch e
    showError "服务器请求出错：#{errorThrown}"

# REF: http://rors.org/demos/custom-confirm-in-rails
$.rails.allowAction = (link) ->
  return true unless link.attr('data-confirm')
  $.rails.showConfirmDialog(link) # look bellow for implementations
  false # always stops the action since code runs asynchronously

$.rails.confirmed = (link) ->
  link.removeAttr('data-confirm')
  link.trigger('click.rails')

$.rails.showConfirmDialog = (link) ->
  message = link.attr 'data-confirm'
  alertify.confirm message, -> $.rails.confirmed(link)

$ ->
  alertify.okBtn "确认"
  alertify.cancelBtn "取消"
