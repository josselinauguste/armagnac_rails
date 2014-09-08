require 'test_helper'

class DigestsHelperTest < ActionView::TestCase
  test 'return default string for empty title' do
    entry = Class.new do
      def title; ''; end
    end.new

    assert_equal 'Titre vide', entry_title(entry)
  end

  test 'return empty string for nil content' do
    entry = Class.new do
      def summary; nil; end
      def content; nil; end
    end.new

    assert blank_entry?(entry)
  end
end
