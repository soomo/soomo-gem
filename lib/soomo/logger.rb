require 'logger'

module Soomo
  module Logger

    def self.included(base)
      base.send :include, Methods
      base.send :extend, Methods
    end

    module Methods
      def logger
        @__soomo_logger__ ||= defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
      end
    end

  end
end
