require "test_helper"
require "capybara/poltergeist"

options = {js_errors: false,
           timeout: 1000,
           phantomjs_options: [
               '--load-images=no',
               '--ignore-ssl-errors=yes',
               '--ssl-protocol=any']}

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, options)
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  #driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  driven_by :poltergeist, screen_size: [1400, 1400]
end
