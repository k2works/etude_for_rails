require 'test_helper'

class RailsTutorial::Sample::UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = rails_tutorial_sample_users(:michael)
  end

  test "index including pagination" do
    log_in_as(@user)
    get rails_tutorial_sample_users_path
    assert_template 'rails_tutorial/sample/users/index'
    assert_select 'div.pagination'
    RailsTutorial::Sample::User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', rails_tutorial_sample_user_path(user), text: user.name
    end
  end
end
