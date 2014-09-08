require 'test_helper'

class SendDigestsWorkerTest < ActiveSupport::TestCase
  test 'call worker queue one job per feed' do
    assert_difference 'ActionMailer::Base.deliveries.size' do
      SendDigestsWorker.send_digests
    end
  end

  test 'do not call mailer when no new entry' do
    feeds(:rss).update_attribute(:fetched_at, 1.day.ago)

    assert_difference 'ActionMailer::Base.deliveries.size', 0 do
      SendDigestsWorker.send_digests
    end
  end
end
