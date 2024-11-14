require 'net/http'

module Api
  class UrlValidatorController < ApplicationController
    def validate
      url = params[:url]
      is_valid = validate_substack_url(url)
      render json: { url: url, is_valid: is_valid }
    end

    private

    def validate_substack_url(url)
      url = "https://#{url}" unless url.start_with?('http://', 'https://')

      uri = URI.parse(url)
      return false unless uri.host.end_with?('.substack.com')

      begin
        response = Net::HTTP.get_response(uri)
        return response.is_a?(Net::HTTPSuccess)
      rescue SocketError, Errno::ECONNREFUSED, Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError
        false
      end
    end
  end
end