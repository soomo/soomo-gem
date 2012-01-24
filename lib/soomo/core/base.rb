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
            unless self.class.ignored_attributes.include?(name.to_sym)
              $stdout.puts "[WARN] Unable to set #{name}.  If you need this attribute, please add it as an attr_accessor."
            end
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

      def self.attr_ignore(*names)
        names.each {|name| ignored_attributes.add(name) }
      end

      def self.ignored_attributes
        @ignored_attributes ||= Set.new
      end

    end
  end
end
