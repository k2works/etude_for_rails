require 'application_system_test_case'

class WhinepadTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit react_beginners_guide_whinepad_index_path

    assert_text 'Whinepadにようこそ!'
  end

  test "search and filter table" do
    visit react_beginners_guide_whinepad_index_path

    click_on '追加'
    fill_in 'name', with: 'test'
    click_on '追加'


    first('input').set('test')

    assert_text 'test'
  end

  test "add item" do
    visit react_beginners_guide_whinepad_index_path

    click_on '追加'
    fill_in 'name', with: 'テスト'
    fill_in 'year', with: 2018
    fill_in 'grape', with: 'テスト２'
    fill_in 'comments', with: 'テスト３'
    click_on '追加'

    assert_text 'テスト'
  end

  test "sort title" do
    visit react_beginners_guide_whinepad_index_path

    click_on '追加'
    fill_in 'name', with: 'テスト'
    click_on '追加'


    first('th').click
  end

  test "show item" do
    visit react_beginners_guide_whinepad_index_path

    click_on '追加'
    fill_in 'name', with: 'テスト'
    click_on '追加'

    first(:css, "span[class^='Actions__ActionsInfo']").click
  end

  test "edit item" do
    visit react_beginners_guide_whinepad_index_path

    first(:css, "span[class^='Actions__ActionsEdit']").click

    fill_in 'name', with: 'テスト'
    fill_in 'year', with: 2018
    fill_in 'grape', with: 'テスト２'
    fill_in 'comments', with: 'テスト３'
    click_on '保存'

  end

  test "delete item" do
    visit react_beginners_guide_whinepad_index_path

    first(:css, "span[class^='Actions__ActionsDelete']").click

    click_on '削除'

    click_on '追加'
    fill_in 'name', with: 'テスト'
    click_on '追加'

  end

end