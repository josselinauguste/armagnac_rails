require 'test_helper'

class FeedTest < ActiveSupport::TestCase
  test 'get new entries returns all entries if not yet fetched' do
    feed = feeds(:one)

    feed.fetch

    assert_equal 3, feed.new_entries.length
    assert_equal 'Sous les briques, le soleil', feed.title
  end

  test 'get new entries only if already fetched' do
    feed = feeds(:one)
    feed.update_attribute(:fetched_at, Date.parse('2013-07-22'))

    feed.fetch

    assert_equal 1, feed.new_entries.length
    assert_equal 'Going brompton', feed.new_entries.first.title
    assert_equal 'Sous les briques, le soleil', feed.title
  end
end
