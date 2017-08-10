
require 'test_helper'

class RailsTutorial::Sample::FollowingTest < ActionDispatch::IntegrationTest

  def setup
    @user = rails_tutorial_sample_users(:michael)
    log_in_as(@user)
  end

  test "following page" do
    get following_rails_tutorial_sample_user_path(@user)
    assert_not @user.following.empty?
    assert_match @user.following.count.to_s, response.body
    @user.following.each do |user|
      assert_select "a[href=?]", rails_tutorial_sample_user_path(user)
    end
  end

  test "followers page" do
    get followers_rails_tutorial_sample_user_path(@user)
    assert_not @user.followers.empty?
    assert_match @user.followers.count.to_s, response.body
    @user.followers.each do |user|
      assert_select "a[href=?]", rails_tutorial_sample_user_path(user)
    end
  end
end
