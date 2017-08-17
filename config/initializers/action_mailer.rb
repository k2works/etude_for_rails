Rails.application.configure do
  if Rails.env.production? || Rails.env.staging?
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.delivery_method = :smtp
    host = 'etude-for-rails.herokuapp.com'
    config.action_mailer.default_url_options = { host: host }
    ActionMailer::Base.smtp_settings = {
        :address        => 'smtp.sendgrid.net',
        :port           => '587',
        :authentication => :plain,
        :user_name      => ENV['SENDGRID_USERNAME'],
        :password       => ENV['SENDGRID_PASSWORD'],
        :domain         => 'heroku.com',
        :enable_starttls_auto => true
    }
  else
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.delivery_method = :test
    host = 'localhost:3000'                     # ローカル環境
    config.action_mailer.default_url_options = { host: host, protocol: 'http' }
  end
end