class Api::V1::LoginController < ApplicationController
  def index
    code = params[:code]
    session_id = params[:session_id]

    redis = Redis.new

    if redis.get(session_id)
      render json: { result: 'SUCCESS', session_id: session_id }

    elsif code
      openid, session_key = Modules::Wechat.get_wxapp_openid_and_session_key code
      session_id = SecureRandom.hex(8)

      redis.set(session_id, { :openid => openid, :session_key => session_key })

      render json: { result: 'SUCCESS', session_id: session_id }
    else
      render json: { result: 'FAIL' }
    end

  end
end