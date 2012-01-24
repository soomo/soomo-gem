module Soomo
  module Webtext
    class Book < Base

      attr_accessor :uri, :id, :family_id, :name

      def self.find(id)
        new(api.get("/webtext/books/#{id}")['book'])
      end

      def chapters
        api.get("/webtext/books/#{id}/chapters")['chapters'].map do |attrs|
          Chapter.new(attrs['chapter'], :parent => self)
        end
      end

      attr_ignore :type

    end
  end
end
