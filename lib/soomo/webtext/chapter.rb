module Soomo
  module Webtext
    class Chapter < Base

      attr_accessor :uri, :id, :family_id, :name, :book_id
      alias_method :book, :parent

      def pages
        api.get("/webtext/books/#{book_id}/chapters/#{id}/pages")['pages'].map do |attrs|
          Page.new(attrs['page'], :parent => self)
        end
      end

    end
  end
end
