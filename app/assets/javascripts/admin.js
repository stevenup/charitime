//= require jquery
//= require jquery_ujs
//= require lodash/lodash
//= require common/namespace
//= require js-routes

//= require common/ajax-injection
// ajax-injection必须放在simplify_admin之前，timeago的显示和delete的那个action才不会出问题。
// 不知道是不是simplify_admin下哪个js文件对其产生顺序依赖
//= require simplify_admin/simplify_admin
//= require common/notifications-injection
//= require common/utils-common

//= require datatables/media/js/jquery.dataTables
//= require datatables/media/js/dataTables.bootstrap
//= require common/utils-datatables

//= require jquery-timeago/jquery.timeago
//= require jquery-timeago/locales/jquery.timeago.zh-CN

//= require bootstrap-modal/js/bootstrap-modalmanager
//= require bootstrap-modal/js/bootstrap-modal
//= require integrations/bootstrap-modal-bs3-fix
//= require ckeditor/init
