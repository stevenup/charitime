# 支持[Datatables](http://datatables.net)的一些工具方法
namespace 'Utils.Datatables', (exports) ->
  #
  # 创建一个利用AJAX来获取数据的datatables，主要是配合ruby中datatables_helper.rb中的方法使用，具有以下功能：
  # * 读取helper方法`dt_col`中指定的数据列属性并为datatables初始化生成`columns`属性
  # * 读取helper方法`dt`中生成的`table`的`data-url`属性保存的值并作为`datatables`远程数据的来源，数据获取方式为`GET`
  # * 如果没有手动指定`datatables`的`ajax`属性中的`data`节点，当前页面中的`input.filter-input`控件的值会被用`val()`方法读取并通过`data-prop`属性设置到远程数据源需要的`data`内
  #
  # @param {String} container datatable的容器，html table tag
  # @param {Object} opts, datatable的额外选项，可选的选项：参见[datatables的说明](http://datatables.net/reference/option)，缺省为空
  # @return {Object} 所创建的`datatables`对象的`API`对象
  #
  exports.newForAjax = (container, opts = {}) ->
    # 根据table容器内的`th`生成`datatables`需要的列对象
    aoColumns = []
    for th in $("#{container} > thead > tr > th")
      col = {}
      _.each $(th).data(), (v, k) ->
        # 重新调整列配置对象上属性的命名方式为匈牙利命名方式以匹配`datatables`的需求
        newKey = (k.split('_').map (w) -> w[0].toUpperCase() + w[1..-1].toLowerCase()).join('')
        newKey = newKey[0].toLowerCase() + newKey[1..-1]
        col[newKey] = v
        true
      aoColumns.push col

    # 生成`datatables`初始化需要的选项
    newOpts = {
      columns: aoColumns
      serverSide: true
      ajax: {
        url: $(container).data('url')
        data: (d) ->
          # Build up extra server parameters for filtering on input with .filter-input class and data-prop attribute
          _.forEach $('.filter-input'), (fi) ->
            d[$(fi).data('prop')] = $(fi).val()
            true
          d
      }
    }
    $.extend newOpts, opts

    # 创建`datatables`对象，并返回它的`api`对象，添加nowrap css类来保持表格的整洁
    $(container).addClass('nowrap').dataTable(newOpts).api()

  #
  # 初始化Datatables的一些缺省配置设置
  #
  exports.setDefaults = $.extend $.fn.dataTable.defaults,
    paging: true
    lengthChange: true
    info: true
    stateSave: true
    scrollX: true
    autoWidth: true
    dom: "<'row'<'col-sm-6'l><'col-sm-6 text-right'i>><'row'<'col-sm-12't>><'row'<'col-sm-2'r><'col-sm-10'p>>"
    language:
      "sProcessing":   "处理中..."
      "sLengthMenu":   "每页 _MENU_ 条"
      "sZeroRecords":  "没有匹配结果"
      "sInfo":         "第_PAGE_页 共_PAGES_页"   #"显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项"
      "sInfoEmpty":    "显示第 0 至 0 项结果，共 0 项"
      "sInfoFiltered": "(由 _MAX_ 项结果过滤)"
      "sInfoPostFix":  ""
      "sSearch":       "搜索:"
      "sUrl":          ""
      "sEmptyTable":     "表中数据为空"
      "sLoadingRecords": "载入中..."
      "sInfoThousands":  ","
      "oPaginate":
        "sFirst":    "首页"
        "sPrevious": "上页"
        "sNext":     "下页"
        "sLast":     "末页"
      "oAria":
        "sSortAscending":  ": 以升序排列此列"
        "sSortDescending": ": 以降序排列此列"
