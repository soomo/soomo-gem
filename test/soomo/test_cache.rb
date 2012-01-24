module Soomo
  class TestCache < MiniTest::Unit::TestCase

    class TestApp
      include Cache
    end

    def setup
      @cache = TestApp.cache
    end

    def teardown
      @cache = nil
    end

    def test_read
      assert_equal nil, @cache.read('whatever')
    end

    def test_write_with_value
      assert_equal 'identical', @cache.write('key', 'identical')
    end

    def test_write_with_block
      assert_equal 'identical', @cache.write('key') { 'identical' }
    end

    def test_fetch_with_value
      assert_equal 'identical', @cache.fetch('key', 'identical')
    end

    def test_fetch_with_block
      assert_equal 'identical', @cache.fetch('key') { 'identical' }
    end

    def test_delete
      assert_equal false, @cache.delete('whatever')
    end

  end
end
