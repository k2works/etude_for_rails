source 'https://rubygems.org'
ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.2'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', group: :development
gem 'mysql2', group: :development
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'dotenv-rails', groups: [:staging, :development, :test]

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.14.0'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'ruby-debug-ide', '~>0.6.1.beta4'
  gem 'debase', '~>0.2.2.beta9'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rack-dev-mark'
  gem 'guard-livereload', '~> 2.5', require: false
  gem 'rack-livereload'
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails'
  gem 'minitest', '5.10.1'
  gem 'database_rewinder'
  gem 'rspec-json_matcher', require: 'rspec/json_matcher'
  gem 'rails-controller-testing'
  gem 'minitest-reporters',       '1.1.14'
  gem 'guard-minitest',           '2.4.4'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'yard', '~> 0.9.8', group: :doc
  gem 'guard-yard'
  gem 'redcarpet', '~> 3.3', '>= 3.3.4'
  gem 'migration_comments'
  gem 'annotate', group: :doc
  gem 'kss-rails'
  gem 'scss_lint', require: false
  gem 'i18n_generators'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# For Heroku
gem 'rails_12factor', group: :production
gem 'pg', group: :production
gem 'foreman'

# For JavaScript
gem 'webpacker'

gem 'simplecov', :require => false, :group => :test

# For HTMLCSS
gem 'font-awesome-rails'

# For Bootstrap
gem 'jquery-rails'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'bootstrap_form'

# For JavaScript
gem 'js_cookie_rails'

# For Ops
gem 'etude_for_aws', '~> 0.7.10'

# For CodeStar
gem 'passenger'

# For AwesomeEvents
gem 'omniauth', '~> 1.6', '>= 1.6.1'
gem 'omniauth-twitter', '~> 1.4'
# exception_notification
gem 'exception_notification'
gem 'kaminari'
gem 'kaminari-bootstrap', '~> 3.0', '>= 3.0.1'
gem 'ransack'
gem 'carrierwave', '~> 1.0'
gem 'mini_magick'

group :test do
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
end

# For Baukis
gem 'date_validator', '~> 0.9.0'
gem 'email_validator', '~> 1.6'
gem 'jquery-ui-rails', '~> 5.0', '>= 5.0.5'
gem 'tag-it-rails'

# For RailsTutorial
gem 'faker',          '1.7.3'
gem 'will_paginate',           '3.1.5'
gem 'bootstrap-will_paginate', '1.0.0'
gem 'fog',                     '1.40.0'

# For DesignPattern
gem 'madeleine'