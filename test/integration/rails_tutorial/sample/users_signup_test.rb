require 'test_helper'

class RailsTutorial::Sample::UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get rails_tutorial_sample_signup_path
    assert_no_difference 'RailsTutorial::Sample::User.count' do
      post rails_tutorial_sample_users_path, params: { rails_tutorial_sample_user: { name:  "",
                                                               email: "user@invalid",
                                                               password:              "foo",
                                                               password_confirmation: "bar" } }
    end
    assert_template 'rails_tutorial/sample/users/new'
  end

  test "valid signup information" do
    get rails_tutorial_sample_signup_path
    assert_difference 'RailsTutorial::Sample::User.count', 1 do
      post rails_tutorial_sample_users_path, params: { rails_tutorial_sample_user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'rails_tutorial/sample/users/show'
    assert_not flash.nil?
  end
end
