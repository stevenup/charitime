datatable_json_response(json) do
  json.array! @rows do |row|
    json.product_id             row.product_id
    json.product_name           row.product_name
    json.product_price          row.product_price
    json.product_category_id    ProductCategory.find_by(:id => row.product_category_id).try(:product_category_name)
    json.product_label_id       ProductLabel.find_by(:id => row.product_label_id).try(:product_label_name)
    json.gyb_discount           row.gyb_discount
    json.product_detail         timeago(row.product_detail)
    json.product_created_at     timeago(row.product_created_at)
    json.actions                edit_and_del edit_admin_product_path(row), admin_product_path(row, :format => :json), { edit: { data: { id: row.id }, class: 'btn btn-sm btn-info edit-btn' }, delete: { data: { id: row.id, confirm: '确认删除？' }, class: 'btn btn-sm btn-dark delete-btn m-l-xs' } }
  end
end
