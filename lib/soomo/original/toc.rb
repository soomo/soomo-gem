module Soomo
  module Original
    class Toc < Base

      attr_accessor :uri, :id, :family_id, :name

      def self.find(id)
        new(api.get("/original/tocs/#{id}")['toc'])
      end

      def chapters
        api.get("/original/tocs/#{id}/chapters")['chapters'].map do |attrs|
          Chapter.new(attrs['chapter'], :parent => self)
        end
      end

    end
  end
end
