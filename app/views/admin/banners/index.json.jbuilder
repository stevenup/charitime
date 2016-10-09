datatable_json_response(json) do
  json.array! @rows do |row|
    json.title           row.title
    json.image           render_img row.image, :width => '80px', :height => '60px'
    json.created_at      row.created_at.strftime("%Y-%m-%d %T")
    json.actions         edit_and_del edit_admin_banner_path(row), admin_banner_path(row, :format => :json), { edit: { data: { id: row.id }, class: 'btn btn-sm btn-info edit-btn' }, delete: { data: { id: row.id, confirm: '确认删除？' }, class: 'btn btn-sm btn-dark delete-btn m-l-sm' } }
  end
end
