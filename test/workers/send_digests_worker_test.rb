require 'test_helper'

class SendDigestsWorkerTest < ActiveSupport::TestCase
  test 'call worker queue one job per feed' do
    assert_difference 'ActionMailer::Base.deliveries.size' do
      SendDigestsWorker.send_digests
    end
  end
end
