datatable_json_response(json) do
  json.array! @rows do |row|
    json.project_id             row.project_id
    json.project_name           row.project_name
    json.project_type_id        ProjectType.find_by(:id => row.project_type_id).try(:project_type_name)
    json.project_detail         row.project_detail
    json.created_at             timeago(row.created_at)
    json.actions                edit_and_del edit_admin_project_path(row), admin_project_path(row, :format => :json), { edit: { data: { id: row.id }, class: 'btn btn-sm btn-info edit-btn' }, delete: { data: { id: row.id, confirm: '确认删除？' }, class: 'btn btn-sm btn-dark delete-btn m-l-sm' } }
  end
end
