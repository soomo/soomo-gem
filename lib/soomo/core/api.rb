require 'oauth'
require 'json'

module Soomo
  module Core

    class Api
      include Logger
      include Cache

      OAUTH_KEY    = ENV['SOOMO_CORE_OAUTH_KEY']
      OAUTH_SECRET = ENV['SOOMO_CORE_OAUTH_SECRET']
      HOSTNAME     = ENV['SOOMO_CORE_HOSTNAME']
      PROTOCOL     = ENV['RAILS_ENV'] == "production" ? 'https://' : 'http://'

      def get(path, params={}, headers={})
        query = params.map{|k,v| "#{CGI.escape k.to_s}=#{CGI.escape v.to_s}" }.join('&')
        path = "/api/internal#{path}.json"
        path += "?#{query}" unless query == ""

        cache_key = "#{path}:#{headers}"

        if (etag = cache.read("#{cache_key}:etag")) && (data = cache.read("#{cache_key}:data"))
          headers = headers.merge('If-None-Match' => etag)
        end

        response = access_token.get(path, headers)

        if response.code == '304' # Not Modified
          JSON.parse(data)
        else
          cache.write("#{cache_key}:etag", response['ETag'])
          cache.write("#{cache_key}:data", response.body)
          JSON.parse(response.body)
        end
      end

      private

      def access_token
        @access_token ||= ::OAuth::AccessToken.new(consumer)
      end

      def consumer
        @consumer ||= ::OAuth::Consumer.new(OAUTH_KEY, OAUTH_SECRET, :site => PROTOCOL + HOSTNAME)
      end
    end
  end
end
