require "r_aurora/version"

module RAurora
  class Base

    attr_reader :api, :token

    def initialize(base, api, token)
      @uri = URI(base)
      @uri.port = "16021"
      @api = api
      @token = token
    end

  def info
    req = Net::HTTP::Get.new(uri('',''))
    res = Net::HTTP.start(@uri.hostname, @uri.port) {|http|
      http.request(req)
    }
    JSON.parse res.body
  end

    private
    def method_missing(method_name, request_type, domain, payload=nil)
      api_endpoint = camel_case(method_name)
      case request_type
      when "get"
        req = Net::HTTP::Get.new(uri(domain, api_endpoint))
      when "put"
        req = Net::HTTP::Put.new(uri(domain, api_endpoint))
        req.body = payload.to_json
      end
      res = http_request(req)
      p res.code
      JSON.parse res.body rescue res.body
    end

    def http_request(req)
      Net::HTTP.start(@uri.hostname, @uri.port) {|http|
        http.request(req)
      }
    end

    def uri(domain, endpoint)
      URI.join(@uri, @api, @token, domain, endpoint)
    end

    def camel_case(method_name)
      "#{method_name.to_s.split('_').collect(&:capitalize).join.sub(/^\w/) {$&.downcase}}"
    end
  end
end
