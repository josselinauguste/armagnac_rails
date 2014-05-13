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
    feed.update_attribute(:fetched_at, DateTime.parse('2013-07-22 22:30'))

    feed.fetch

    assert_equal 1, feed.new_entries.length
    assert_equal 'Going brompton', feed.new_entries.first.title
    assert_equal 'Sous les briques, le soleil', feed.title
  end

  test 'get empty array if no new entry' do
    feed = feeds(:one)
    feed.update_attribute(:fetched_at, DateTime.now)

    feed.fetch

    assert_equal 0, feed.new_entries.length
  end
end
