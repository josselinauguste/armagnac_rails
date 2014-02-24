require 'test_helper'

class DigestsControllerTest < ActionController::TestCase
  test 'send digests' do
    get :process_feeds

    assert_response :success
  end
end
