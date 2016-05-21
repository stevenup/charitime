module Wepay
  module Service
    PAY_URL = 'https://api.mch.weixin.qq.com'

    UNIFIEDORDER_REQUIRED_PARAMS = %i( body out_trade_no total_free spbill_create_ip notify_url trade_type )
    def self.invoke_unifiedorder(params, options = {})
      url = "#{ PAY_URL }/pay/unifiedorder"
      params = {
        :appid     => Settings.wepay.appid,
        :mch_id    => Settings.wepay.mch_id,
        :nonce_str => SecureRandom.uuid.tr('-', '')
      }.merge(params)
      check_required_params(params, UNIFIEDORDER_REQUIRED_PARAMS)
      send_request(url, generate_params(params), options)
    end

    class << self
      private
      def check_required_params(params, required_params)
        required_params.each do |name|
          warn("Wepay Warn: missing required param: #{ name }") unless params.has_key?(name)
        end
      end

      def generate_params params
        sign = Wepay::Sign.generate params
        "<xml>#{ params.map { |k, v| "<#{ k }>#{ v }</#{ k }>" }.join }<sign>#{ sign }</sign></xml>"
      end

      def send_request(url, params, options = {})
        res = conn.post url, params, options
        Wepay::Result.new(Hash.from_xml(res.body).delete('xml'))
      end

      def conn
        Faraday.new(:url => PAY_URL) do |faraday|
          faraday.request  :multipart
          faraday.response :logger, ::Logger.new(STDOUT), bodies: true unless Rails.env.production?
          faraday.adapter  Faraday.default_adapter
        end
      end
    end
  end

  class Result < ::Hash
    def success?
      self['return_code'] == 'SUCCESS' && self['result_code'] == 'SUCCESS'
    end
  end
end
