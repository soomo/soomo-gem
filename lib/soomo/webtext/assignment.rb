module Soomo
  module Webtext
    class Assignment < Base

      attr_accessor :uri, :id, :family_id, :name, :content, :page_id
      alias_method :page, :parent
      def chapter; page.chapter; end

      def video_clips
        api.get("/webtext/books/#{chapter.book_id}/chapters/#{page.chapter_id}/pages/#{page_id}/assignments/#{id}/video_clips")['video_clips'].map do |attrs|
          VideoClip.new(attrs['video_clip'], :parent => self)
        end
      end

    end
  end
end
