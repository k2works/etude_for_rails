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

  test "login with valid information followed by logout" do
    get rails_tutorial_sample_login_path
    post rails_tutorial_sample_login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", rails_tutorial_sample_login_path, count: 0
    assert_select "a[href=?]", rails_tutorial_sample_logout_path
    assert_select "a[href=?]", rails_tutorial_sample_user_path(@user)
    delete rails_tutorial_sample_logout_path
    assert_not is_logged_in?
    assert_redirected_to rails_tutorial_sample_root_url
    # 2番目のウィンドウでログアウトをクリックするユーザーをシミュレートする
    delete rails_tutorial_sample_logout_path
    follow_redirect!
    assert_select "a[href=?]", rails_tutorial_sample_login_path
    assert_select "a[href=?]", rails_tutorial_sample_logout_path,      count: 0
    assert_select "a[href=?]", rails_tutorial_sample_user_path(@user), count: 0
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies['rails_tutorial_sample_remember_token']
  end

  test "login without remembering" do
    # クッキーを保存してログイン
    log_in_as(@user, remember_me: '1')
    delete rails_tutorial_sample_logout_path
    # クッキーを削除してログイン
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['rails_tutorial_sample_remember_token']
  end
end