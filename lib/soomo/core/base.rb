module Soomo
  module Core
    class Base
      include Logger
      include Cache

      attr_reader :parent

      def initialize(attrs = {}, options = {})
        attrs.each do |name, value|
          begin
            self.send "#{name}=", value
          rescue NoMethodError => e
            $stdout.puts "[WARN] Unable to set #{name}.  If you need this attribute, please add it as an attr_accessor."
          end
        end
        @parent = options[:parent]
      end

      def api
        @api ||= Api.new
      end

      def api=(api)
        @api = api
      end

      def self.api
        @api ||= Api.new
      end

      def self.api=(api)
        @api = api
      end

    end
  end
end
