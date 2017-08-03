require 'test_helper'

class RailsTutorial::Sample::UsersControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    get rails_tutorial_sample_signup_url
    assert_response :success
  end
end