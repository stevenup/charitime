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
    if row.is_published == '1'
      json.actions         edit_and_del 'javascript:;', 'javascript:;',
                                        {
                                          edit: { class: 'btn btn-sm btn-disable btn-table-action edit-btn' },
                                          delete: { class: 'btn btn-sm btn-disable btn-table-action delete-btn m-l-sm' }
                                        }
      if row.is_recommended == '1'
        json.more_actions    more_actions %w(预览 撤销发布 取消推荐),
                                          [ preview_admin_project_path(row.id), depublish_admin_project_path(row), reset_recommend_admin_project_path(row) ],
                                          [
                                              { class: 'btn btn-sm btn-info btn-table-action preview-btn', target: '_blank' },
                                              { class: 'btn btn-sm btn-info btn-table-action publish-btn', data: { confirm: '确认撤销发布该项目?' }},
                                              { class: 'btn btn-sm btn-info btn-table-action reset-recommend-btn', data: { confirm: '确认取消推荐该项目?' }}
                                          ]
      else
        json.more_actions    more_actions %w(预览 撤销发布 加入推荐),
                                          [ preview_admin_project_path(row.id), depublish_admin_project_path(row), recommend_admin_project_path(row) ],
                                          [
                                              { class: 'btn btn-sm btn-info btn-table-action preview-btn', target: '_blank' },
                                              { class: 'btn btn-sm btn-info btn-table-action publish-btn', data: { confirm: '确认撤销发布该项目?' }},
                                              { class: 'btn btn-sm btn-info btn-table-action recommend-btn', data: { confirm: '确认推荐该项目?' }}
                                          ]
      end

    else
      json.actions         edit_and_del edit_admin_project_path(row), admin_project_path(row, :format => :json),
                                        {
                                          edit: { class: 'btn btn-sm btn-info btn-table-action edit-btn' },
                                          delete: { data: { confirm: '确认删除？' }, class: 'btn btn-sm btn-dark btn-table-action delete-btn m-l-sm' }
                                        }
      json.more_actions    more_actions %w(预览 发布),
                                        [ preview_admin_project_path(row.id), publish_admin_project_path(row) ],
                                        [
                                            { class: 'btn btn-sm btn-info btn-table-action preview-btn', target: '_blank' },
                                            { class: 'btn btn-sm btn-info btn-table-action publish-btn', data: { confirm: '确认发布该项目?' }}
                                        ]
    end
  end
end
