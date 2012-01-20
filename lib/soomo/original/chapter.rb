module Soomo
  module Original
    class Chapter < Base

      attr_accessor :uri, :id, :family_id, :name, :toc_id
      alias_method :toc, :parent

      def assignments
        api.get("/original/tocs/#{toc_id}/chapters/#{id}/assignments")['assignments'].map do |attrs|
          Assignment.new(attrs['assignment'], :parent => self)
        end
      end

      def links
        api.get("/original/tocs/#{toc_id}/chapters/#{id}/links")['links'].map do |attrs|
          Link.new(attrs['link'], :parent => self)
        end
      end

    end
  end
end
