require 'application_system_test_case'

class HtmlCssBookTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit html_css_book_index_index_path

    assert_text 'NEWS'
  end

  test "visiting the campaign page" do
    visit html_css_book_index_index_path

    all('.button')[0].click

    assert_text 'CAMPAIGN'
  end


  test "visiting the article page" do
    visit html_css_book_index_index_path

    all('.Menu__item')[3].click

    assert_text 'コーヒースクール'
  end
end