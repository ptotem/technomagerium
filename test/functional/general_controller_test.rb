require 'test_helper'

class GeneralControllerTest < ActionController::TestCase
  test "should get privacy" do
    get :privacy
    assert_response :success
  end

end
