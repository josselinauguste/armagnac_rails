require 'test_helper'

class DigestMailerTest < ActionMailer::TestCase

  class FakeEntry
    def title
      'Salut'
    end

    def url
      'http://www.test.com/salut'
    end

    def summary
      'salut les gars'
    end
  end
  
  test 'send digest for feed' do
    to = 'jauguste@iblop.net'
    email = nil
    entries = [FakeEntry.new]

    assert_difference 'ActionMailer::Base.deliveries.size' do
      email = DigestMailer.feed_digest('Sous les briques, le soleil', entries, to).deliver
    end

    assert_equal [to], email.to
    assert_equal ['bouilleurdecru@armagnac.io'], email.from
    assert_equal "Your digest about 'Sous les briques, le soleil'", email.subject
  end
end
