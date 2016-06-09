$ ->
  $.ajax ({
    type: 'GET',
    url: '/wepay/init_wx_js_info',
    data: { "url": window.location.href.split('#')[0] },
    success: (res) ->
      info = res['data'];
      config_wechat(info.appid, info.timestamp, info.noncestr, info.signature);
  })

config_wechat = (appid, timestamp, noncestr, signature) ->
  wx.config ({
    debug: true,
    appId: appid,
    timestamp: timestamp,
    nonceStr: noncestr,
    signature: signature,
    jsApiList: [
      'onMenuShareTimeline',
      'onMenuShareAppMessage',
      'onMenuShareQQ',
      'onMenuShareWeibo',
      'chooseWXPay'
    ]
  })
