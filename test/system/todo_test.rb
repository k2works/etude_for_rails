require 'application_system_test_case'

class TodoTest < ApplicationSystemTestCase
=begin
  test 'visiting the index' do
    Todo::DB.prepare_for_test

    visit todo_tasks_path

    assert_text 'Listing Tasks'
  end

  test 'new task' do
    Todo::DB.prepare_for_test

    visit todo_tasks_path

    click_link 'New'

    fill_in 'Name', :with => 'お名前'

    fill_in 'Content', :with => '牛乳を買う'

    click_button 'Create'

    assert_text 'Task was successfully created.'
  end

  test 'edit task' do
    Todo::DB.prepare_for_test
    Todo::Task.new(name:'お名前', content:'内容').save!

    visit todo_tasks_path

    click_link 'Edit'

    fill_in 'Name', :with => '名前更新'

    fill_in 'Content', :with => '内容更新'

    select('DONE', :from => 'todo_task[status]')

    click_button 'Update'

    assert_text 'Task was successfully updated.'
  end
=end

=begin
  ChromeHeadlessではモーダルを使ったシステムテストができない #26
  https://github.com/teamcapybara/capybara/issues/1860
  test 'delete task' do
    Todo::DB.prepare_for_test
    Todo::Task.new(name:'お名前', content:'内容').save!

    visit todo_tasks_path

    accept_confirm do
      click_link 'Delete'
    end

    assert_no_text 'お名前'
    assert_no_text '内容'
  end
=end

end
