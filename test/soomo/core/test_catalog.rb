module Soomo
  module Core
    class TestCatalog < MiniTest::Unit::TestCase

      class TestApi
        def initialize(ret_val)
          @ret_val = ret_val
        end
        def get(path, params={}, headers={})
          @ret_val
        end
      end

      def setup
        @catalog = Soomo::Core::Catalog.new({
          uri: 'soomo://core/catalogs/catalog',
          entries: [
            {thing_id: 'test1', family_id: 'test1', commit_id: 'test1', title_id: 'test1'},
            {thing_id: 'test2', family_id: 'test2', commit_id: 'test2', title_id: 'test2'}
          ]
        })

        @things_hash = {'things' => [
          {'thing' => {'type' => 'NG::Soomo::Toc', 'name' => 'toc1'}},
          {'thing' => {'type' => 'NG::Soomo::Toc', 'name' => 'toc2'}},
          {'thing' => {'type' => 'NG::Traditional::Book', 'name' => 'book'}},
          {'thing' => {'type' => 'NG::Soomo::Assignment', 'name' => 'a1'}},
          {'thing' => {'type' => 'NG::Soomo::Assignment', 'name' => 'a2'}},
          {'thing' => {'type' => 'NG::Soomo::Link', 'name' => 'link'}},
        ]}

        @catalog.api = TestApi.new(@things_hash)
      end

      def test_initialize
        assert_equal 'soomo://core/catalogs/catalog', @catalog.uri
        assert_equal 2, @catalog.entries.length
      end

      def test_things
        things = @catalog.things
        assert_equal @things_hash['things'].length, things.length

        thing = things[0]
        assert_equal 'NG::Soomo::Toc', thing.properties['type']
        assert_equal 'toc1', thing.properties['name']
      end

      def test_books
        books = @catalog.books
        assert_equal 1, books.length
      end

      def test_tocs
        tocs = @catalog.tocs
        assert_equal 2, tocs.length
      end

      def test_assignments
        assignments = @catalog.assignments
        assert_equal 2, assignments.length
      end

      def test_links
        links = @catalog.links
        assert_equal 1, links.length
      end

    end
  end
end
