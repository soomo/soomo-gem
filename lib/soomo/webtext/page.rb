module Soomo
  module Webtext
    class Page < Base

      attr_accessor :uri, :id, :family_id, :name, :content, :chapter_id
      alias_method :chapter, :parent

      def assignments
        api.get("/webtext/books/#{chapter.book_id}/chapters/#{chapter_id}/pages/#{id}/assignments")['assignments'].map do |attrs|
          Assignment.new(attrs['assignment'], :parent => self)
        end
      end

    end
  end
end
