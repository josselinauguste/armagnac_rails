require 'test_helper'

class SendDigestsWorkerTest < ActiveSupport::TestCase
  test 'call worker queue one job per feed' do
    assert_difference 'ActionMailer::Base.deliveries.size' do
      SendDigestsWorker.send_digests
    end
  end

  test 'perform for a feed' do
    feed = feeds(:one)

    assert_difference 'ActionMailer::Base.deliveries.size' do
      SendDigestsWorker.new.perform(feed.id)
    end
  end
end
