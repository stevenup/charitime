namespace :wechat do
  task :create_buttons => :environment do
    btn_info = {
        "button" => [
            {
                "type" => "view",
                "name" => "Charitime",
                "url" => "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{ Settings.wechat.appid }&redirect_uri=#{ Settings.wechat.redirect_uri }&response_type=code&scope=snsapi_base&state=123456#wechat_redirect"
            }
        ]
    }.to_json.gsub!(/\\u([0-9a-z]{4})/) {|s| [$1.to_i(16)].pack("U")}

    puts btn_info
    url = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=#{ Modules::Wechat.get_access_token }"
    res = HTTPClient.post(url, btn_info)
    puts res.body
  end
end
