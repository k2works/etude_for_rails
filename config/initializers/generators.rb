Rails.application.config.generators do |g|
  g.helper false
  g.assets false
  g.test_framework :rspec
  g.controller_specs false
  g.view_specs false
end