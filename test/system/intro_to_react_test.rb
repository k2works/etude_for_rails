require 'application_system_test_case'

class IntroToReactTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit intro_to_reacts_intro_to_react_index_path

    assert_text 'IntroToReact'
  end

  test "click square on game board" do
    visit intro_to_reacts_intro_to_react_index_path

    7.times.each do |n|
      #page.all('.square')[n].click
    end

    7.times.each do |n|
      #assert_text "Move #" + (n + 1).to_s
    end
  end
end