require 'test_helper'

class DigestMailerTest < ActionMailer::TestCase
  
  test 'send digest for feed' do
    to = 'jauguste@iblop.net'
    feed = feeds(:one)
    feed.fetch
    email = nil

    assert_difference 'ActionMailer::Base.deliveries.size' do
      email = DigestMailer.digest_email(feed.title, feed.new_entries, to).deliver
    end

    assert_equal [to], email.to
    assert_equal ['bouilleurdecru@armagnac.io'], email.from
    assert_equal "Your weekly digest for the feed 'Sous les briques, le soleil'", email.subject
  end
end
