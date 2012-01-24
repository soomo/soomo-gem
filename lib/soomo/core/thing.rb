module Soomo
  module Core
    class Thing < Base
      extend Cache

      attr_accessor :properties, :type

      def self.find(id)
        new(api.get("/things/#{id}")['thing'])
      end

      def initialize(properties)
        @properties = properties
        @type = properties['type']
      end

    end
  end
end

