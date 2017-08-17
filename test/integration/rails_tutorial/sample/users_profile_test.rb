require 'test_helper'

class RailsTutorial::Sample::UsersProfileTest < ActionDispatch::IntegrationTest
  include RailsTutorial::ApplicationHelper

  def setup
    @user = rails_tutorial_sample_users(:michael)
  end

  test "profile display" do
    get rails_tutorial_sample_user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title("(test) #{@user.name}")
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end
end
