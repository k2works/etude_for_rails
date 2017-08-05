require 'test_helper'

class RailsTutorial::Sample::SessionsControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    get rails_tutorial_sample_login_path
    assert_response :success
  end
end
