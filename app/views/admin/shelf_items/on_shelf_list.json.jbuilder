datatable_json_response(json) do
  json.array! @rows do |row|
    json.product_id             row.product_id
    json.product_name           row.product_name
    json.thumb                  render_img Product.find_by(:product_id => row.product_id).try(:thumb), :width => '80px', :height => '80px'
    json.category               row.category
    json.created_at             row.created_at.strftime("%Y-%m-%d %T")
    if row.recommended == '1'
      json.more_actions           more_actions %w(下架 取消推荐),
                                               [pull_off_shelf_admin_shelf_item_path(row), reset_recommended_admin_shelf_item_path(row)],
                                               [
                                                 { class: 'btn btn-sm btn-info off-shelf-btn', data: { confirm: '确认下架？'} },
                                                 { class: 'btn btn-sm btn-info recommend-btn', data: { confirm: '确认取消推荐？'} }
                                               ]
    else
      json.more_actions           more_actions %w(下架 加入推荐),
                                               [pull_off_shelf_admin_shelf_item_path(row), set_recommended_admin_shelf_item_path(row)],
                                               [
                                                 { class: 'btn btn-sm btn-info off-shelf-btn', data: { confirm: '确认下架？'} },
                                                 { class: 'btn btn-sm btn-info recommend-btn', data: { confirm: '确认加入推荐？'} }
                                               ]
    end
  end
end
