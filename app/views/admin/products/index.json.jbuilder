datatable_json_response(json) do
  json.array! @rows do |row|
    json.product_id       row.product_id
    json.product_name     row.product_name
    json.thumb            render_img row.thumb, :width => '80px', :height => '80px'
    json.main_pic         render_img row.main_pic, :width => '140px', :height => '75px'
    json.category         row.category
    json.purpose          row.purpose
    json.created_at       row.created_at.strftime('%Y-%m-%d %T')
    json.actions          edit_and_del edit_admin_product_path(row), admin_product_path(row, :format => :json), { edit: { data: { id: row.id }, class: 'btn btn-sm btn-info edit-btn' }, delete: { data: { id: row.id, confirm: '确认删除？' }, class: 'btn btn-sm btn-dark delete-btn m-l-sm' } }
    json.more_actions     row_action '预览', preview_admin_product_path(row.id), { class: 'btn btn-sm btn-info preview-btn', target: '_blank' }
  end
end
