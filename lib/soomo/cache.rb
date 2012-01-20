require 'singleton'

module Soomo
  module Cache

    def self.included(base)
      base.send :include, Methods
      base.send :extend, Methods
    end

    module Methods
      def cache
        defined?(Rails) ? Rails.cache : NilFactory.instance
      end

      class NilFactory
        include Singleton
        def method_missing(method, *args, &block)
          nil
        end
      end
    end

  end
end
