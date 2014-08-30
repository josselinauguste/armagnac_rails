require 'test_helper'

class FetchFacebookFeedTest < ActiveSupport::TestCase
  setup do
    WebMock.disable!
  end

  teardown do
    WebMock.enable!
  end

  test 'fetch valid facebook feed' do
    feed = Feed.create!({
      source: 'rodadechorodebordeaux',
      format: 'facebook'
    })
      
    title, entries = FetchFeedService.new.fetch_new(feed)

    assert_not_empty title
    assert_not_empty entries
  end
end