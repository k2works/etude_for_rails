require 'test_helper'

class RailsTutorial::SessionsHelperTest < ActionView::TestCase

  def setup
    @user = rails_tutorial_sample_users(:michael)
    remember(@user)
  end

  test "current_user returns right user when session is nil" do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test "current_user returns nil when remember digest is wrong" do
    @user.update_attribute(:remember_digest, RailsTutorial::Sample::User.digest(RailsTutorial::Sample::User.new_token))
    assert_nil current_user
  end
end
