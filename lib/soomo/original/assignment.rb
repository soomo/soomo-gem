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

      attr_ignore :type, :type_proxy, :thumbnail_id,
                  :head_1, :head_2, :head_3, :head_4,
                  :rendered_content, :parts, :clips,
                  :quiz_type, :quizzes, :quiz_parts,
                  :short_description, :catalog_description,
                  :length_in_minutes, :editorial_notes,
                  :title_id, :publisher_id, :prep_time, :blurb

    end
  end
end
