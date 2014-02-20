require 'test_helper'

class SendDigestsWorkerTest < ActiveSupport::TestCase
  test 'call worker queue one job per feed' do
    assert_difference 'SendDigestsWorker.jobs.size', Feed.count do
      SendDigestsWorker.send_digests
    end

    assert_equal Feed.first.id, SendDigestsWorker.jobs.first['args'][0]
  end

  test 'perform for a feed' do
    feed = feeds(:one)

    assert_difference 'ActionMailer::Base.deliveries.size' do
      SendDigestsWorker.new.perform(feed.id)
    end

    assert_operator feed.reload.fetched_at, :>, 5.seconds.ago
  end
end
