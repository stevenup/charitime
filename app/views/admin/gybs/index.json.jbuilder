datatable_json_response(json) do
  json.array! @rows do |row|
    json.id                     row.id
    json.title                  row.title
    json.gyb_type               row.gyb_type
    json.price                  row.price
    json.stock                  row.stock
    json.expiration_time        row.expiration_time.strftime('%Y-%m-%d').to_s
    json.created_at             timeago(row.created_at)
    json.actions                edit_and_del edit_admin_gyb_path(row), admin_gyb_path(row, :format => :json), { edit: { data: { id: row.id }, class: 'btn btn-sm btn-info edit-btn' }, delete: { data: { id: row.id, confirm: '确认删除？' }, class: 'btn btn-sm btn-dark delete-btn m-l-sm' } }
  end
end
