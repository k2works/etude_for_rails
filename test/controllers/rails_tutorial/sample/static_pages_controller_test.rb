require 'test_helper'

class RailsTutorial::Sample::StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get rails_tutorial_sample_static_pages_home_url
    assert_response :success
  end

  test "should get help" do
    get rails_tutorial_sample_static_pages_help_url
    assert_response :success
  end
end