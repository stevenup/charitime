datatable_json_response(json) do
  json.array! @rows do |row|
    json.project_type_name      row.project_type_name
    json.created_at             timeago(row.created_at)
    json.actions                edit_and_del edit_admin_project_type_path(row), admin_project_type_path(row, :format => :json), { edit: { data: { id: row.id }, class: 'btn btn-sm btn-primary edit-btn' }, delete: { data: { id: row.id, confirm: '确认删除？' }, class: 'btn btn-sm btn-dark delete-btn m-l-sm' } }
  end
end
