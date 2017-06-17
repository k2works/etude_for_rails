Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,
           Rails.application.secrets.twitter_api_key,
           Rails.application.secrets.twitter_api_secret

  if Rails.env != 'production'
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
                                                                     :provider => 'twitter',
                                                                     :uid => '123545',
                                                                     :info => {nickname:'Test',image:'DUMMY'}
                                                                 })
  end
end