module Soomo
  module Original
    class Assignment < Base

      attr_accessor :uri, :id, :family_id, :name, :content, :chapter_id
      alias_method :chapter, :parent

      def video_clips
        api.get("/original/tocs/#{chapter.toc_id}/chapters/#{chapter_id}/assignments/#{id}/video_clips")['video_clips'].map do |attrs|
          VideoClip.new(attrs['video_clip'], :parent => self)
        end
      end

    end
  end
end
