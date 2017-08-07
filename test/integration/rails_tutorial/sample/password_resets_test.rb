require 'test_helper'

class RailsTutorial::Sample::PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = rails_tutorial_sample_users(:michael)
  end

  test "password resets" do
    get new_rails_tutorial_sample_password_reset_path
    assert_template 'password_resets/new'
    # メールアドレスが無効
    post rails_tutorial_sample_password_resets_path, params: { password_reset: { email: "" } }
    assert_not flash.empty?
    assert_template 'rails_tutorial/sample/password_resets/new'
    # メールアドレスが有効
    post rails_tutorial_sample_password_resets_path,
         params: { password_reset: { email: @user.email } }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to rails_tutorial_sample_root_url
    # パスワード再設定フォームのテスト
    user = assigns(:user)
    # メールアドレスが無効
    get edit_rails_tutorial_sample_password_reset_path(user.reset_token, email: "")
    assert_redirected_to rails_tutorial_sample_root_url
    # 無効なユーザー
    user.toggle!(:activated)
    get edit_rails_tutorial_sample_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to rails_tutorial_sample_root_url
    user.toggle!(:activated)
    # メールアドレスが有効で、トークンが無効
    get edit_rails_tutorial_sample_password_reset_path('wrong token', email: user.email)
    assert_redirected_to rails_tutorial_sample_root_url
    # メールアドレスもトークンも有効
    get edit_rails_tutorial_sample_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email
    # 無効なパスワードとパスワード確認
    patch rails_tutorial_sample_password_reset_path(user.reset_token),
          params: { email: user.email,
                    rails_tutorial_sample_user: { password:              "foobaz",
                            password_confirmation: "barquux" } }
    assert_select 'div#error_explanation'
    # パスワードが空
    patch rails_tutorial_sample_password_reset_path(user.reset_token),
          params: { email: user.email,
                    rails_tutorial_sample_user: { password:              "",
                            password_confirmation: "" } }
    assert_select 'div#error_explanation'
    # 有効なパスワードとパスワード確認
    patch rails_tutorial_sample_password_reset_path(user.reset_token),
          params: { email: user.email,
                    rails_tutorial_sample_user: { password:              "foobaz",
                            password_confirmation: "foobaz" } }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
  end

  test "expired token" do
    get new_rails_tutorial_sample_password_reset_path
    post rails_tutorial_sample_password_resets_path,
         params: { password_reset: { email: @user.email } }

    @user = assigns(:user)
    @user.update_attribute(:reset_sent_at, 3.hours.ago)
    patch rails_tutorial_sample_password_reset_path(@user.reset_token),
          params: { email: @user.email,
                    rails_tutorial_sample_user: { password:              "foobar",
                            password_confirmation: "foobar" } }
    assert_response :redirect
    follow_redirect!
    assert_match /Password reset has expired/i, response.body
  end
end