require 'test_helper'

class RailsTutorial::Sample::StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get rails_tutorial_sample_static_pages_home_url
    assert_response :success
    assert_select "title", "(test) Home | Ruby on Rails Tutorial Sample App"
  end

  test "should get help" do
    get rails_tutorial_sample_static_pages_help_url
    assert_response :success
    assert_select "title", "(test) Help | Ruby on Rails Tutorial Sample App"
  end

  test "should get about" do
    get rails_tutorial_sample_static_pages_about_url
    assert_response :success
    assert_select "title", "(test) About | Ruby on Rails Tutorial Sample App"
  end

end