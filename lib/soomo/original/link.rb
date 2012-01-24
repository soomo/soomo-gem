module Soomo
  module Original
    class Link < Base

      attr_accessor :uri, :id, :family_id, :name, :url, :chapter_id
      alias_method :chapter, :parent
      alias_method :link_name=, :name=

      attr_ignore :type, :description, :title_id, :link_image_url

    end
  end
end
