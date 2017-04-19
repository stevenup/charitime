require 'base64'
require 'json'
require 'digest'

module Modules::Kdniao

  def sign_data(req_data)
    ## NOTE:
    # Sb logistic API use ' in json API /wx
    req_data = req_data.to_json.gsub('"', "'")
    md5_str = Digest::MD5.hexdigest("#{req_data}#{Settings.kdniao.APIKey}")
    puts '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
    encoded = Base64.encode64(md5_str)
    URI::encode(encoded.chomp)
  end

  module_function :sign_data
end
