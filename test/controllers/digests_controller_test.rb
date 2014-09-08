require 'test_helper'

class DigestsControllerTest < ActionController::TestCase
  test 'send digests' do
    time = Job.last.updated_at

    assert_difference 'ActionMailer::Base.deliveries.size' do
      Delorean.time_travel_to DateTime.parse('2014-06-13 20:00:00') do
        get :watch
      end
    end

    assert_response :success
    assert_operator time, :<, Job.last.reload.updated_at
  end

  test 'do not send digests if out of schedule' do
    time = Job.last.updated_at

    assert_difference 'ActionMailer::Base.deliveries.size', 0 do
      Delorean.time_travel_to DateTime.parse('2014-06-12 20:00:00') do
        get :watch
      end
    end

    assert_response :success
    assert_equal time, Job.last.reload.updated_at
  end

  test 'send digests if forced' do
    time = Job.last.updated_at

    assert_difference 'ActionMailer::Base.deliveries.size' do
      Delorean.time_travel_to DateTime.parse('2014-06-12 20:00:00') do
        get :watch, force: '1'
      end
    end

    assert_response :success
    assert_operator time, :<, Job.last.reload.updated_at
  end

  test 'do not send digests twice on the same day' do
    time = DateTime.parse('2014-06-12 20:00:00')
    Job.last.update_attribute(:updated_at, time.change({hours: 8}))

    assert_difference 'ActionMailer::Base.deliveries.size', 0 do
      Delorean.time_travel_to time do
        get :watch
      end
    end

    assert_response :success
    assert_equal time, Job.last.reload.updated_at
  end
end
