datatable_json_response(json) do
  json.array! @rows do |row|
    json.project_id      row.project_id
    json.project_name    row.project_name
    json.thumb           render_img row.thumb,    :width => '60px', :height => '60px'
    json.banner          render_img row.banner,   :width => '80px', :height => '60px'
    json.main_pic        render_img row.main_pic, :width => '80px', :height => '60px'
    json.category        row.category
    json.goal            row.goal
    json.created_at      row.created_at.strftime('%Y-%m-%d %T')
    json.more_actions    more_actions %w(预览 取消推荐),
                                      [ preview_admin_project_path(row.id), reset_recommend_admin_projects_path(row.id) ],
                                      [
                                          { class: 'btn btn-sm btn-info btn-table-action preview-btn', target: '_blank' },
                                          { class: 'btn btn-sm btn-info btn-table-action publish-btn', data: { confirm: "确认取消推荐该项目?", id: row.id }}
                                      ]
  end
end
