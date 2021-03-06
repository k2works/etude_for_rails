# == Schema Information
#
# Table name: rails_tutorial_sample_users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class RailsTutorial::Sample::UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = rails_tutorial_sample_users(:michael)
    @other_user = rails_tutorial_sample_users(:archer)
  end

  test "should redirect index when not logged in" do
    get rails_tutorial_sample_users_path
    assert_redirected_to rails_tutorial_sample_login_url
  end

  test "should get new" do
    get rails_tutorial_sample_signup_url
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_rails_tutorial_sample_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to rails_tutorial_sample_login_url
  end

  test "should redirect update when not logged in" do
    patch rails_tutorial_sample_user_path(@user), params: { rails_tutorial_sample_user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to rails_tutorial_sample_login_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch rails_tutorial_sample_user_path(@other_user), params: {
        rails_tutorial_sample_user: { password:              "foobar",
                                      password_confirmation: "foobar",
                                      admin: true } }
    assert_not @other_user.admin?
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'RailsTutorial::Sample::User.count' do
      delete rails_tutorial_sample_user_path(@user)
    end
    assert_redirected_to rails_tutorial_sample_login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'RailsTutorial::Sample::User.count' do
      delete rails_tutorial_sample_user_path(@user)
    end
    assert_redirected_to rails_tutorial_sample_root_url
  end

  test "should redirect following when not logged in" do
    get following_rails_tutorial_sample_user_path(@user)
    assert_redirected_to rails_tutorial_sample_login_url
  end

  test "should redirect followers when not logged in" do
    get followers_rails_tutorial_sample_user_path(@user)
    assert_redirected_to rails_tutorial_sample_login_url
  end
end
