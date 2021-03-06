datatable_json_response(json) do
  json.array! @rows do |row|
    json.product_id         row.product_id
    json.product_name       row.product_name
    json.thumb              render_img row.thumb, :width => '80px', :height => '80px'
    json.category           row.category
    json.purpose            row.purpose
    json.created_at         row.created_at.strftime('%Y-%m-%d %T')
    json.action             row_action '编辑上架', edit_admin_shelf_item_path(row), { class: 'btn btn-sm btn-info on-shelf-btn', 'data-id' => row.id }
  end
end
