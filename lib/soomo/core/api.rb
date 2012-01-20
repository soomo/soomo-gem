require 'oauth'
require 'json'

module Soomo
  module Core

    class Api
      include Logger
      include Cache

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
        @consumer ||= ::OAuth::Consumer.new(oauth_key, oauth_secret, :site => protocol + hostname)
      end

      def oauth_key
        ENV['SOOMO_CORE_OAUTH_KEY']
      end

      def oauth_secret
        ENV['SOOMO_CORE_OAUTH_SECRET']
      end

      def protocol
        ENV['RAILS_ENV'] == "production" ? 'https://' : 'http://'
      end

      def hostname
        ENV['SOOMO_CORE_HOSTNAME']
      end
    end
  end
end
