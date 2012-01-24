require 'singleton'

module Soomo
  module Cache

    def self.included(base)
      base.send :include, Methods
      base.send :extend, Methods
    end

    module Methods
      def cache
        defined?(Rails) ? Rails.cache : DumbCache.instance
      end
    end

    class DumbCache
      include Singleton
      def initialize
        @cache = {}
      end
      def read(key, options={})
        @cache[key]
      end
      def write(key, value=nil, options={}, &block)
        if block_given?
          @cache[key] = block.call
        else
          @cache[key] = value
        end
      end
      def fetch(key, value=nil, options={}, &block)
        if options[:force]
          write(key, value, options, &block)
        else
          read(key) || write(key, value, options, &block)
        end
      end
      def delete(key, options={})
        @cache.delete(key) || false
      end
      def method_missing(method, *args, &block)
        raise "DumbCache##{method} not implemented."
      end
    end

  end
end
