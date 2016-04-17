# -*- encoding : utf-8 -*-
module DatatablesHelper
  # Generate a html table tag for supporting ajax datatables
  #
  # == Parameters:
  #
  # options::
  #   Options which will simply passed to content_tag method
  #
  # block::
  #   Content for thead, which is required for ajax datatable
  #
  # == Usage:
  #
  #   <%= dt id: 'entities-list', class: 'display', :'data-url' => info_articles_path(:format => :json),
  #        :'data-sorting_column' => (if current_sys.selfdrive? then 4 else 5 end), :'data-sorting_dir' => 'desc' do %>
  #    <%= dt_col(data: { m_data_prop: 'id', s_type: 'numeric', s_width: '50px' }){ InfoArticle.human_attribute_name :id } %>
  #    ...
  #    <%= dt_col(data: { m_data_prop: 'actions', s_width: '70px', b_sortable: 'false' }) { t 'actions' } %>
  #  <% end %>
  #
  def datatable_tag(options, &block)
    # 在我的用例中，使用autoWidth来自动计算列宽，使用scrollX来允许表格横向滚动，但是这样会造成表格内容少的时候右边出现空白，所以需要强制设置宽度为100%
    # 如果需要额外设置，可以通过options传入来覆盖
    content_tag :table, ({width: '100%'}).merge(options) do
      html = ''
      html << content_tag(:thead) { yield }
      html << content_tag(:tbody)
      raw html
    end
  end
  alias :dt :datatable_tag

  # Similiar to @datatable_tag method but this will pass section as the block parameter,
  # means in the block, we have to render sections accordingly.
  # We support :thead, :tbody and :tfoot right now
  def datatable_tag_section(options, &block)
    content_tag :table, options do
      html = ''
      html << content_tag(:thead) { yield(:thead) }
      html << content_tag(:tbody) { yield(:tbody) }
      html << content_tag(:tfoot) do
        content_tag(:tr) { yield(:tfoot) }
      end
      raw html
    end
  end
  alias :dts :datatable_tag_section

  # Generate th html tag for building up ajax datatable html tag
  #
  # == Parameters:
  #
  # options::
  #   Options which will be passed to content_tag method. To be awared, an node named "data" will be treated as
  #   an hash, and it will be used to build HTML options with pattern like "data-*"
  #
  # == Usage:
  #   To render a datatable column with data property id:
  #     dt_col(data: { m_data_prop: 'id', s_type: 'numeric', s_width: '50px' }){ InfoArticle.human_attribute_name :id }
  #   This will render:
  #     <th data-m_data_prop="id" data-s_type="numeric" data-s_width="50px">编号</th>
  #
  #   To render a datatable column with data property actions, with sorting feature disabled:
  #     dt_col(data: { m_data_prop: 'actions', s_width: '70px', b_sortable: 'false' }) { t 'actions' }
  #   This will render:
  #     <th data-b_sortable="0" data-m_data_prop="actions" data-s_width="70px">操作</th>
  #
  def datatable_col_tag(name = nil, options = {}, &block)
    options = name if block_given?
    data_options = options.delete :data
    # Build up data options
    data = {}
    data_options.each { |k, v| data["data-#{k}"] = v } if data
    if block_given?
      content_tag(:th, options.merge(data)) { yield }
    else
      content_tag(:th, name, options.merge(data))
    end
  end
  alias :dt_col :datatable_col_tag

  # Shortcut method for datatable_col_tag for those columns with needs for only data attributes
  #
  # == Parameters:
  # col_title::
  #   Column title
  # data_options::
  #   Hash represent data attributes
  #
  # == Usage:
  #   <%= d_col InfoArticle.human_attribute_name(:info_column_id ), m_data_prop: 'info_column_name', s_width: '60px' %>
  def datatable_col_tag_dataonly(col_title, data_options)
    datatable_col_tag(data: data_options) { col_title }
  end
  alias :d_col :datatable_col_tag_dataonly

  # A short function to wrap actions group for table rows with two buttons, one editting and one for deleting.
  # Editing is actually a hyperlink and delete is actually a remote action
  # == Parameters:
  # edit_target::
  #   Link target for editing
  # del_target::
  #   Link target for deleting
  # opts::
  #   Options to be passed to the buttons, :edit for edit button and :del for delete button
  # == Usage:
  #     edit_and_del edit_route_path(row), route_path(row, :format => :json), {edit: {data:{id: 1}}, del: {data:{id: 1}}}
  #
  def render_edit_and_del_actions(edit_target, del_target, opts = {})
    row_actions [
      {
        target: edit_target,
        link_text: '编辑',
        options: opts.delete(:edit)
      },
      {
        target: del_target,
        link_text: '删除',
        options: { :method => :delete }.merge(opts.delete(:delete))
      }
    ]
  end
  alias :edit_and_del :render_edit_and_del_actions

  def render_recommend_action(recommend_target, opts = {})
    recommend_actions [
      {
        target: recommend_target,
        link_text: '加入推荐',
        options: opts
      }
    ]

  end

  def render_recommend_row_actions(buttons)
    actions = '<div>'
    buttons.each do |b|
      b[:options] ||= {}
      actions << link_to(raw(b[:link_text]), '#', b[:options])
    end
    actions << '</li></ul></div>'
  end
  alias :recommend_actions :render_recommend_row_actions

  # Generate Img codes in jbuidler
  def render_img(url, options ={})
    image_tag url, options
  end

  # Generate HTML codes for array of buttons for each row in a html grid.
  #
  # == Parameters:
  # buttons::
  #   An array contains buttons information to be included in HTML table row, which normally will be the last col.
  #   Ruby link_to function will be used for each button in the array, each button of the array will be an hash,
  #   it should contained following information:
  #     :target: Link target
  #     :link_text: Text to include between begin and end tag of an A ancor
  #     :button_style: Button style class, if this has been indicated, this function won't apply it's default class
  #     :options: Extra options to be assigned to the link_to function, except the :class key, it will be combinted
  #             with some default css classes
  # == Returns:
  # HTML codes to be inserted into html table row cell, to present actions in each table row.
  #
  # == Usage:
  #   row_actions [
  #      { target: edit_route_path(row), link_text: icon(:edit), options: data {data: id} },
  #      {
  #        target: route_path(row, :format => :json), link_text: icon(:'trash-o'), button_style: :'btn-danger',
  #        options: { :remote => true, :method => :delete, :data => { :confirm => tv('delete_row_confirm') } }
  #      }
  #    ]
  #
  def render_table_row_actions(buttons)
    actions = '<div>'
    buttons.each do |b|
      b[:options] ||= {}
      actions << link_to(raw(b[:link_text]), b[:target], b[:options])
    end
    actions << '</li></ul></div>'
  end
  alias :row_actions :render_table_row_actions

  # Helper to be used in jbuilder for rendering datatable json response
  #
  # == Usages:
  #     datatable_json_response do
  #       json.foo 'bar'
  #     end
  #
  # @return Datatable json response
  def datatable_json_response(json, &block)
    json.draw params['draw'] || 0
    json.recordsTotal @total_rows
    json.recordsFiltered @total_rows_filtered || @total_rows
    if defined?(@error)
      json.error @error
    else
      json.data &block
    end
  end
end
