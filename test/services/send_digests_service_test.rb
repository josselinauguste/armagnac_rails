require 'test_helper'

class SendDigestsServiceTest < ActiveSupport::TestCase
  setup do
    @service = SendDigestsService.new
  end

  test 'send digest for a feed' do
    feed = feeds(:one)

    assert_difference 'ActionMailer::Base.deliveries.size' do
      @service.send(feed.id)
    end

    assert_operator feed.reload.fetched_at, :>, 5.seconds.ago
  end

  test 'do not send digest for feed without new entry' do
    feed = feeds(:one)
    feed.update_attribute(:fetched_at, DateTime.now)

    assert_difference 'ActionMailer::Base.deliveries.size', 0 do
      @service.send(feed.id)
    end
  end
end
