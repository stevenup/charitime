namespace :wechat do
  task :create_buttons => :environment do
    btn_info = {
        "button" => [
            {
              :name => 'My',
              :sub_button => [
                {
                  :type => 'view',
                  :name => '我的订单',
                  :url => "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{ Settings.wechat.appid }&redirect_uri=#{ Settings.button.button1_uri }&response_type=code&scope=snsapi_base&state=12345#wechat_redirect"
                },
                {
                  :type => 'view',
                  :name => '我的公益币',
                  :url => "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{ Settings.wechat.appid }&redirect_uri=#{ Settings.button.button2_uri }&response_type=code&scope=snsapi_base&state=12345#wechat_redirect"
                },
                {
                  :type => 'view',
                  :name => '退款售后',
                  :url => "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{ Settings.wechat.appid }&redirect_uri=#{ Settings.button.button3_uri }&response_type=code&scope=snsapi_base&state=12345#wechat_redirect"
                }]
            },
            {
              :name => 'Good',
              :sub_button => [
                {
                  :type => 'view',
                  :name => '好物',
                  :url => "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{ Settings.wechat.appid }&redirect_uri=#{ Settings.button.button4_uri }&response_type=code&scope=snsapi_base&state=12345#wechat_redirect"
                },
                {
                  :type => 'view',
                  :name => '优活',
                  :url => "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{ Settings.wechat.appid }&redirect_uri=#{ Settings.button.button5_uri }&response_type=code&scope=snsapi_base&state=12345#wechat_redirect"
                }]
            },
            {
              :name => 'Buy',
              :sub_button => [
                {
                  :type => 'view',
                  :name => '主页',
                  :url => "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{ Settings.wechat.appid }&redirect_uri=#{ Settings.wechat.redirect_uri }&response_type=code&scope=snsapi_base&state=12345#wechat_redirect"
                }
              ]
            }
        ]
    }.to_json.gsub!(/\\u([0-9a-z]{4})/) {|s| [$1.to_i(16)].pack("U")}

    puts btn_info
    url = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=#{ Modules::Wechat.get_access_token }"
    res = HTTPClient.post(url, btn_info)
    puts res.body
  end
end
