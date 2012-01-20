module Soomo
  module Original
    class VideoClip < Base

      attr_accessor :uri, :id, :family_id, :name, :url, :credits_url, :transcript_url, :poster_url, :assignment_id
      alias_method :assignment, :parent

    end
  end
end
