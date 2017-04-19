class Api::V1::LoginController < ApplicationController
  def index
    code, session_id, encrypted_data, iv = params[:code], params[:session_id], params[:encrypted_data], params[:iv]
    raw_data, signature                  = params[:raw_data], params[:signature]

    redis = Redis.new

    # Login to the server
    if redis.get(session_id)
      render json: { result: 'SUCCESS', session_id: session_id }

    elsif code
      openid, session_key = Modules::Wxapp.get_wxapp_openid_and_session_key code
      session_id          = SecureRandom.hex(8)

      redis.set(session_id, { :openid => openid, :session_key => session_key })

      # Verify the user's info.
      if Modules::Wxapp.sign_verified?(raw_data, session_key, signature)
        # Decrypt the user's info.
        decrypted_data = Modules::Wxapp.wx_biz_data_decrypt(Settings.wxapp.appid, session_key, encrypted_data, iv)

        # Detect whether the user info is existed.
        # Save the info if not existed.
        unless User.find_by_openid(decrypted_data['openId'])
          user_info              = {}
          user_info[:openid]     = decrypted_data['openId']
          user_info[:nickname]   = decrypted_data['nickName']
          user_info[:sex]        = decrypted_data['gender']
          user_info[:language]   = decrypted_data['language']
          user_info[:province]   = decrypted_data['province']
          user_info[:city]       = decrypted_data['city']
          user_info[:country]    = decrypted_data['country']
          user_info[:headimgurl] = decrypted_data['avatarUrl']
          user                   = User.new user_info
          user.save
        end

        # Return the session id to the wxapp if the user's sign verified.
        render json: { result: 'SUCCESS', session_id: session_id }
      else
        render json: { result: 'INVALID SIGNATURE' }
      end

    else
      render json: { result: 'FAIL' }
    end

  end
end