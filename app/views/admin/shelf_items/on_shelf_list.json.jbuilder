datatable_json_response(json) do
  json.array! @rows do |row|
    json.product_id             row.product_id
    json.product_name           row.product_name
    json.thumb                  render_img Product.find_by(:product_id => row.product_id).try(:thumb), :width => '80px', :height => '80px'
    json.product_category_id    ProductCategory.find_by(:id => row.product_category_id).try(:product_category_name)
    json.product_label_id       ProductLabel.find_by(:id => row.product_label_id).try(:product_label_name)
    json.product_detail         row.product_detail
    json.created_at             timeago(row.created_at)
    json.off_shelf              off_shelf admin_shelf_item_path(row), {id: row.id, class: 'btn btn-sm btn-info off-shelf-btn', confirm: '确认下架？' }
  end
end
