# Preview all emails at http://localhost:3000/rails/mailers/rails_tutorial/sample/user_mailer
class RailsTutorial::Sample::UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/rails_tutorial/sample/user_mailer/account_activation
  def account_activation
    RailsTutorial::Sample::UserMailer.account_activation
  end

  # Preview this email at http://localhost:3000/rails/mailers/rails_tutorial/sample/user_mailer/password_reset
  def password_reset
    RailsTutorial::Sample::UserMailer.password_reset
  end

end
