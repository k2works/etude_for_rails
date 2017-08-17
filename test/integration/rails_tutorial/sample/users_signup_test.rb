require 'test_helper'

class RailsTutorial::Sample::UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

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

  test "valid signup information with account activation" do
    get rails_tutorial_sample_signup_path
    assert_difference 'RailsTutorial::Sample::User.count', 1 do
      post rails_tutorial_sample_users_path, params: { rails_tutorial_sample_user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # 有効化していない状態でログインしてみる
    log_in_as(user)
    assert_not is_logged_in?
    # 有効化トークンが不正な場合
    get edit_rails_tutorial_sample_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?
    # トークンは正しいがメールアドレスが無効な場合
    get edit_rails_tutorial_sample_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # 有効化トークンが正しい場合
    get edit_rails_tutorial_sample_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'rails_tutorial/sample/users/show'
    assert is_logged_in?
  end

end
