require 'test_helper'

class RailsTutorial::Sample::UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = rails_tutorial_sample_users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_rails_tutorial_sample_user_path(@user)
    assert_template 'rails_tutorial/sample/users/edit'
    patch rails_tutorial_sample_user_path(@user), params: { rails_tutorial_sample_user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'rails_tutorial/sample/users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_rails_tutorial_sample_user_path(@user)
    assert_template 'rails_tutorial/sample/users/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch rails_tutorial_sample_user_path(@user), params: { rails_tutorial_sample_user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end