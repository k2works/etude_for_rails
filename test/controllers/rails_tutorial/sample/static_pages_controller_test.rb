require 'test_helper'

class RailsTutorial::Sample::StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get rails_tutorial_sample_root_url
    assert_response :success
    assert_select "title", "(test) Ruby on Rails Tutorial Sample App"
  end

  test "should get help" do
    get rails_tutorial_sample_help_url
    assert_response :success
    assert_select "title", "(test) Help | Ruby on Rails Tutorial Sample App"
  end

  test "should get about" do
    get rails_tutorial_sample_about_url
    assert_response :success
    assert_select "title", "(test) About | Ruby on Rails Tutorial Sample App"
  end

  test "should get contact" do
    get rails_tutorial_sample_contact_url
    assert_response :success
    assert_select "title", "(test) Contact | Ruby on Rails Tutorial Sample App"
  end

end