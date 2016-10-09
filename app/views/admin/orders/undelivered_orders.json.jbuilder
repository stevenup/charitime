datatable_json_response(json) do
  json.array! @rows do |row|
    json.user_id       row.user_id
    json.order_id      row.order_id
    json.order_status  row.order_status
    json.total_price   row.total_price
    json.created_at    row.created_at.strftime("%Y-%m-%d %T")
    json.actions       row_action '发货', edit_admin_order_path(row), { edit: { data: { id: row.id }, class: 'btn btn-sm btn-info edit-btn' }, class: 'btn btn-sm btn-dark delete-btn m-l-sm' }
  end
end
