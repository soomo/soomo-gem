module Soomo
  module Original
    class Link < Base

      attr_accessor :uri, :id, :family_id, :name, :url, :chapter_id
      alias_method :chapter, :parent

    end
  end
end
