datatable_json_response(json) do
  json.array! @rows do |row|
    json.user_id       row.user_id
    json.order_id      row.order_id
    json.order_status  transform_status(row.order_status.to_s, row.logistics_status.to_s)
    json.total_price   row.total_price
    json.created_at    row.created_at.strftime("%Y-%m-%d %T")
  end
end
