require 'digest/md5'

module Wepay
  module Sign
    # pass in a hash obj including all params such as { :name => 'qq', :action => 'fk' }
    def self.generate params
      str_sign_tmp = params.sort.map do |k, v|
        "#{ k }=#{ v }" if !v.nil? && v != ''
      end.compact.join('&')
      str_sign_tmp += "&key=#{ Settings.wepay.key }"
      Digest::MD5.hexdigest(str_sign_tmp).upcase
    end

    def self.verify? params
      params = params.dup
      sign = params.delete('sign') || params.delete(:sign)
      generate(params) == sign
    end
  end
end
