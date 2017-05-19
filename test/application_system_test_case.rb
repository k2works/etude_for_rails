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
  caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => %w(--headless)})
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400], options: { desired_capabilities: caps }
  #driven_by :poltergeist, screen_size: [1400, 1400]
end

module Capybara
  module Node
    class Element
      def double_click
        session.driver.browser.mouse.double_click(self.native)
      end
      def context_click
        session.driver.browser.action.context_click(self.native).perform
      end
    end
  end
end