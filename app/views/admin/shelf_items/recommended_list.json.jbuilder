datatable_json_response(json) do
  json.array! @rows do |row|
    json.product_id      row.product_id
    json.product_name    row.product_name
    json.thumb           render_img Product.find_by(:product_id => row.product_id).try(:thumb), :width => '80px', :height => '80px'
    json.category        row.category
    json.created_at      row.created_at.strftime('%Y-%m-%d %T')
    json.action          row_action '取消推荐', reset_recommended_admin_shelf_item_path(row), {id: row.id, class: 'btn btn-sm btn-info recommend-cancel-btn', data: { confirm: "确认取消推荐？"} }
  end
end
