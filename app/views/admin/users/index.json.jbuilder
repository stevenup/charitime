datatable_json_response(json) do
  json.array! @rows do |row|
    json.openid       row.openid
    json.headimgurl   render_img row.headimgurl, :width => '60px', :height => '60px'
    json.nickname     row.nickname
    json.mobile       row.mobile
    json.sex          row.sex == 1 ? '男' : '女'
    json.country      row.country
    json.province     row.province
    json.city         row.city
    json.subscribe    row.subscribe == 1 ? '已关注' : '未关注'
    json.created_at   timeago(row.created_at)
    json.address      row.address
    json.gyb          row.gyb
  end
end
