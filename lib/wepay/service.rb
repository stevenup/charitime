require 'openssl'

module Wepay
  module Service
    PAY_URL = 'https://api.mch.weixin.qq.com'

    UNIFIEDORDER_REQUIRED_PARAMS = %i( body out_trade_no total_fee spbill_create_ip notify_url trade_type )
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

    REFUND_REQUIRED_PARAMS = %i( out_trade_no out_refund_no total_fee refund_fee op_user_id )
    def self.invoke_refund(params, options = {})
      Wepay::Service.get_apiclient_by_pkcs12
      url = "#{ PAY_URL }/secapi/pay/refund"
      params = {
        :appid      => Settings.wepay.appid,
        :mch_id     => Settings.wepay.mch_id,
        :nonce_str  => SecureRandom.uuid.tr('-', ''),
        :op_user_id => Settings.wepay.mch_id
      }.merge(params)
      check_required_params(params, REFUND_REQUIRED_PARAMS)
      options = {
        ssl_client_cert: Wepay::Service.apiclient_cert,
        ssl_client_key:  Wepay::Service.apiclient_key,
        verify_ssl:      OpenSSL::SSL::VERIFY_NONE
      }
      send_request(url, generate_params(params), options)
    end

    class << self
      attr_accessor :apiclient_key, :apiclient_cert
      def get_apiclient_by_pkcs12
        pkcs12 = OpenSSL::PKCS12.new(File.read(Settings.wepay.pkcs12, 'rb'))
        @apiclient_cert = pkcs12.certificate
        @apiclient_key  = pkcs12.key
      end

      def apiclient_cert=(cert)
        @apiclient_cert = OpenSSL::X509::Certificate.new(cert)
      end

      def apiclient_key=(key)
        @apiclient_key = OpenSSL::PKey::RSA.new(key)
      end

      private
      def check_required_params(params, required_params)
        required_params.each do |name|
          warn("Wepay Warn: missing required param: #{ name }") unless params.has_key?(name)
        end
      end

      def generate_params params
        sign = Wepay::Sign.generate params
        sign = "<xml>#{ params.map { |k, v| "<#{ k }>#{ v }</#{ k }>" }.join }<sign>#{ sign }</sign></xml>"
      end

      def send_request(url, params, options = {})
        res = conn.post url, params, options
        Hash.from_xml(res.body).delete('xml')
      end

      def conn
        Faraday.new(:url => PAY_URL) do |faraday|
          faraday.request  :multipart
          faraday.response :logger, ::Logger.new(STDOUT), bodies: true unless Rails.env.production?
          faraday.adapter Faraday.default_adapter
        end
      end
    end
  end
end
