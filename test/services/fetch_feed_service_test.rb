require 'test_helper'

class FetchFeedServiceTest < ActiveSupport::TestCase
  setup do
    @service = FetchFeedService.new
  end

  test 'get new entries returns all entries if not yet fetched' do
    feed = feeds(:one)

    title, new_entries = @service.fetch_new(feed)

    assert_equal 3, new_entries.length
    assert_equal 'Sous les briques, le soleil', title
  end

  test 'get new entries only if already fetched' do
    feed = feeds(:one)
    feed.update_attribute(:fetched_at, DateTime.parse('2013-07-22 22:30'))

    title, new_entries = @service.fetch_new(feed)

    assert_equal 1, new_entries.length
    assert_equal 'Going brompton', new_entries.first.title
    assert_equal 'Sous les briques, le soleil', title
  end

  test 'get empty array if no new entry' do
    feed = feeds(:one)
    feed.update_attribute(:fetched_at, DateTime.now)

    title, new_entries = @service.fetch_new(feed)

    assert_equal 0, new_entries.length
  end

  test 'get title & entries for a feed' do
    feed = feeds(:one)

    title, new_entries = @service.fetch_new(feed)

    assert_equal 'Sous les briques, le soleil', title
    assert_equal 3, new_entries.length
    assert_operator feed.reload.fetched_at, :>, 5.seconds.ago
  end

  test 'returns empty for feed without new entry' do
    feed = feeds(:one)
    feed.update_attribute(:fetched_at, DateTime.now)

    title, new_entries = @service.fetch_new(feed)

    assert_equal 'Sous les briques, le soleil', title
    assert_empty new_entries
  end
end
