require 'test_helper'

class RailsTutorial::Sample::UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = rails_tutorial_sample_users(:michael)
  end

  test "unsuccessful edit" do
    get edit_rails_tutorial_sample_user_path(@user)
    assert_template 'rails_tutorial/sample/users/edit'
    patch rails_tutorial_sample_user_path(@user), params: { rails_tutorial_sample_user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'rails_tutorial/sample/users/edit'
  end
end