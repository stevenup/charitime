datatable_json_response(json) do
  json.array! @rows do |row|
    json.id               row.id
    json.user_id          row.user_id
    json.project_name     row.project.project_name
    json.project_id       row.project.project_id
    json.support_type     row.support_type == '0' ? '无偿支持' : '购买支持'
    json.money            "¥#{'%.2f' % (row.money / 100)}"
    json.order_detail_id  row.order_detail_id || '无'
    json.created_at       row.created_at.strftime('%Y-%m-%d %T')
  end
end
