class Api::V1::LoginController < ApplicationController
  def index
    code = params[:code]
    session_id = params[:session_id]

    binding.pry

    if session[:session_id]
      render json: { result: 'SUCCESS', session_id: session_id }

      binding.pry

    elsif code
      p 'code is >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
      p code

      openid, session_key = Modules::Wechat.get_wxapp_openid_and_session_key code
      session_id = SecureRandom.hex(8)

      session[:session_id] = { :openid => openid, :session_key => session_key }

      p 'session id is >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
      p session_id

      p 'session is >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
      p session[:session_id]

      render json: { result: 'SUCCESS', session_id: session_id }
    else
      render json: { result: 'FAIL' }
    end

  end
end