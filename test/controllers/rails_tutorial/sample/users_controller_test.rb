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

end
