datatable_json_response(json) do
  json.array! @rows do |row|
    json.id            row.id
    json.title         row.title
    json.image         render_img row.image, :width => '64px', :height => '34px'
    json.is_custom     row.is_custom    == '1' ? '定制' : '非定制'
    json.is_published  row.is_published == '1' ? '已发布' : '未发布'
    json.created_at    row.created_at.strftime('%Y-%m-%d %T')
    if row.is_published == '0'
      json.actions       edit_and_del edit_admin_carousel_path(row), admin_carousel_path(row, :format => :json), { edit: { data: { id: row.id }, class: 'btn btn-sm btn-info edit-btn' }, delete: { data: { id: row.id, confirm: '确认删除？' }, class: 'btn btn-sm btn-dark delete-btn m-l-sm' } }
      json.more_actions  more_actions %w(预览 发布),
                                      [ preview_admin_carousel_path(row.id), publish_admin_carousel_path(row) ],
                                      [
                                          { class: 'btn btn-sm btn-info btn-table-action preview-btn', target: '_blank' },
                                          { class: 'btn btn-sm btn-info btn-table-action publish-btn', data: { confirm: '发布之前，确保已预览过。确认发布该轮播?' }}
                                      ]
    else
      json.actions       edit_and_del 'javascript:;', 'javascript:;', { edit: { class: 'btn btn-sm btn-disable edit-btn' }, delete: { class: 'btn btn-sm btn-disable delete-btn m-l-sm' } }
      json.more_actions  more_actions %w(预览 撤销发布),
                                      [ preview_admin_carousel_path(row.id), depublish_admin_carousel_path(row) ],
                                      [
                                          { class: 'btn btn-sm btn-info btn-table-action preview-btn', target: '_blank' },
                                          { class: 'btn btn-sm btn-info btn-table-action depublish-btn', data: { confirm: '确认撤下该轮播?' }}
                                      ]
    end

  end
end
