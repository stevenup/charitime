datatable_json_response(json) do
  json.array! @rows do |row|
    json.product_category_id    row.product_category_id
    json.product_name           row.product_category_name
    json.created_at             timeago(row.created_at)
    json.actions                edit_and_del edit_admin_product_category_path(row), admin_product_categories_path(row, :format => :json), { edit: { data: { id: row.id }, class: 'btn btn-sm btn-info edit-btn' }, delete: { data: { id: row.id, confirm: '确认删除？' }, class: 'btn btn-sm btn-dark delete-btn m-l-xs' } }
  end
end
