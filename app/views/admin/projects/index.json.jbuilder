datatable_json_response(json) do
  json.array! @rows do |row|
    json.project_id      row.project_id
    json.project_name    row.project_name
    json.thumb           render_img row.thumb,    :width => '60px', :height => '60px'
    json.banner          render_img row.banner,   :width => '80px', :height => '60px'
    json.main_pic        render_img row.main_pic, :width => '80px', :height => '60px'
    json.category        row.category
    json.goal            row.goal
    json.created_at      row.created_at.strftime("%Y-%m-%d %T")
    json.actions         edit_and_del edit_admin_project_path(row), admin_project_path(row, :format => :json),
                                  {
                                    edit: { data: { id: row.id }, class: 'btn btn-sm btn-info btn-table-action edit-btn' },
                                    delete: { data: { id: row.id, confirm: '确认删除？' }, class: 'btn btn-sm btn-dark btn-table-action delete-btn m-l-sm' }
                                  }

    json.more_actions    more_actions %w(预览 发布), [preview_admin_project_path(row.id), publish_admin_project_path(row)],
                                [
                                  { class: 'btn btn-sm btn-info btn-table-action preview-btn', target: '_blank' },
                                  { class: 'btn btn-sm btn-info btn-table-action publish-btn', data: { confirm: "确认发布该项目?", id: row.id }}
                                ]
  end
end
