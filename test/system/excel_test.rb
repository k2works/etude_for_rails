require 'application_system_test_case'

class ExcelTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit react_beginners_guide_excel_index_path

    assert_text 'Excel'
  end

  test "search and filter table" do
    visit react_beginners_guide_excel_index_path

    click_on '検索'

    first('input').set('None')

    assert_text 'And Then There Were None'
  end

  test "sort title" do
    visit react_beginners_guide_excel_index_path

    first('th').click

    assert_equal('And Then There Were None',first('td').text)
  end

=begin
# PolterGeistでは動かない
  test "edit title" do
    visit react_beginners_guide_excel_index_path

    all('td')[0].double_click
    all('td')[0].click
    first('input').set('Edit')
    all('td')[1].double_click

    page.has_content?('Edit')
  end
=end
end