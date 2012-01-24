module Soomo
  module Core
    class Course < Base
      include Cache

      attr_accessor :uri, :id, :name, :number, :instructor_id, :resource_type, :resource_id, :created_at, :updated_at

      def self.find(id)
        new(api.get("/courses/#{id}")['course'])
      end

      def self.published(bust_cache=false)
        cache.fetch("soomo/core/course/self/published/response", :expires_in => 30.minutes, :force => bust_cache) do
          api.get("/courses", status: 'published')['courses']
        end.map {|attrs| new(attrs['course']) }
      end

      def updated_at=(_updated_at)
        @updated_at = _updated_at.kind_of?(String) ? Time.parse(_updated_at) : _updated_at
      end

      def resource_type=(type)
        return @resource_type = nil if type.blank?

        @resource_type = case type
        when "NG::Soomo::Toc" then "Soomo::Original::Toc"
        when "NG::Traditional::Book" then "Soomo::Webtext::Book"

        # TODO
        when "SoomoLearningEnvironment" then nil
        when "NG::Soomo::Book" then nil
        when "NG::Nwlm::Schedule" then nil

        # Erroneous
        when "NG::Soomo::Question" then
          logger.warn "#{type} is not a valid course resource. See course ##{id}"
          nil

        else ExceptionService.notify("Unknown resource type: #{type.class.name} [#{type}]")
        end
      end

      def resource
        if resource_type and resource_id
          resource_type.constantize.find(resource_id)
        else
          nil
        end
      end

    end
  end
end
