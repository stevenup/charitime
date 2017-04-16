require 'base64'
require 'json'
require 'digest'

module Modules::Kdniao

  def sign_data(req_data)
    md5_str = Digest::MD5.hexdigest("#{req_data}#{Settings.kdniao.APIKey}")
    puts '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
    encoded = Base64.encode64(md5_str)
    URI::encode(encoded.chomp)
  end

  module_function :sign_data
end