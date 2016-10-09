datatable_json_response(json) do
  json.array! @rows do |row|
    json.project_id         row.project_id
    json.project_name       row.project_name
    json.thumb              render_img row.thumb,    :width => '60px', :height => '60px'
    json.banner             render_img row.banner,   :width => '80px', :height => '60px'
    json.main_pic           render_img row.main_pic, :width => '80px', :height => '60px'
    json.category           row.category
    json.created_at         row.created_at.strftime("%Y-%m-%d %T")
    json.actions            edit_and_del edit_admin_project_path(row), admin_project_path(row, :format => :json), { edit: { data: { id: row.id }, class: 'btn btn-sm btn-info edit-btn' }, delete: { data: { id: row.id, confirm: '确认删除？' }, class: 'btn btn-sm btn-dark delete-btn m-l-sm' } }
    json.preview_action     row_action '预览', preview_admin_project_path(row.id), { class: 'btn btn-sm btn-info preview-btn', target: '_blank' }
    json.publish_action     row_action '发布', publish_admin_project_path(row), {id: row.id, class: 'btn btn-sm btn-info publish-btn', data: { confirm: "确认发布该项目？"}}
  end
end
