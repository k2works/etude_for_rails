# Preview all emails at http://localhost:3000/rails/mailers/rails_tutorial/sample/user_mailer
class RailsTutorial::Sample::UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/rails_tutorial/sample/user_mailer/account_activation
  def account_activation
    user = RailsTutorial::Sample::User.first
    user.activation_token = RailsTutorial::Sample::User.new_token
    RailsTutorial::Sample::UserMailer.account_activation(user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/rails_tutorial/sample/user_mailer/password_reset
  def password_reset
    user = RailsTutorial::Sample::User.first
    user.reset_token = RailsTutorial::Sample::User.new_token
    RailsTutorial::Sample::UserMailer.password_reset(user)
  end

end
