module Soomo
  module Core
    class Catalog < Base
      extend Cache

      attr_accessor :repo, :title_id, :uri, :entries

      def self.find(repo, title_id=nil)
        path = "/catalogs/#{repo}"
        params = title_id ? {title_id: title_id} : {}
        new(api.get(path, params)['catalog'])
      end

      def initialize(*args)
        super

        @uri =~ /catalogs\/([^\/]+)/
        @repo = $1
        raise "repo cannot be blank." if @repo.nil? or @repo == ""

        @uri =~ /titles\/([^\/]+)/
        @title_id = $1
      end

      def things
        @things ||= begin
          path = "/catalogs/#{repo}/things"
          params = title_id ? {title_id: title_id} : {}
          api.get(path, params)['things'].map {|attrs|
            Thing.new(attrs['thing'])
          }
        end
      end

      def books
        @books ||= things.select {|t| t.type =~ /Traditional::Book/ }.map {|book|
          Webtext::Book.new(book.properties)
        }
      end

      def tocs
        @tocs ||= things.select {|t| t.type =~ /Soomo::Toc/ }.map {|toc|
          Original::Toc.new(toc.properties)
        }
      end

      def assignments
        @assignments ||= things.select {|t| t.type =~ /Soomo::Assignment/ }.map {|a|
          Original::Assignment.new(a.properties)
        }
      end

      def links
        @links ||= things.select {|t| t.type =~ /Soomo::Link/ }.map {|link|
          Original::Link.new(link.properties)
        }
      end

    end
  end
end
