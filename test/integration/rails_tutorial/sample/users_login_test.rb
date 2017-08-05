require 'test_helper'

class RailsTutorial::Sample::UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = rails_tutorial_sample_users(:michael)
  end

  test "login with invalid information" do
    get rails_tutorial_sample_login_path
    assert_template 'sessions/new'
    post rails_tutorial_sample_login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get rails_tutorial_sample_root_path
    assert flash.empty?
  end
end