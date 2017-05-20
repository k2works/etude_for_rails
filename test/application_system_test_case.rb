require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  #driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => %w(--headless --no-sandbox --disable-gpu)})
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400], options: { desired_capabilities: caps }
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