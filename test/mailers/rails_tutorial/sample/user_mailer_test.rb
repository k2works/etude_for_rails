require 'test_helper'

class RailsTutorial::Sample::UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = rails_tutorial_sample_users(:michael)
    user.activation_token = RailsTutorial::Sample::User.new_token
    mail = RailsTutorial::Sample::UserMailer.account_activation(user)
    assert_equal "Account activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.name,               mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    assert_match CGI.escape(user.email),  mail.body.encoded
  end

  test "password_reset" do
    user = rails_tutorial_sample_users(:michael)
    user.reset_token = RailsTutorial::Sample::User.new_token
    mail = RailsTutorial::Sample::UserMailer.password_reset(user)
    assert_equal "Password reset", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.reset_token,        mail.body.encoded
    assert_match CGI.escape(user.email),  mail.body.encoded
  end

end
