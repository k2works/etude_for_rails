require 'application_system_test_case'

class AwesomeEvents::AwesomeEventsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit awesome_events_welcome_index_path

    assert_text 'AwesomeEvents'
  end

  test "login" do
    visit awesome_events_welcome_index_path

    click_link 'Twitterでログイン'

    assert_text 'ログインしました'
  end

  test "create ticket" do
    event = FactoryGirl.create(:event)

    visit awesome_events_welcome_index_path

    click_link 'Twitterでログイン'

    visit awesome_events_event_path(event)

    page.execute_script "window.scrollBy(0,10000)"

    click_on '参加する'

    fill_in 'awesome_events_ticket[comment]', with: '参加します!'

    click_on '送信'

    visit awesome_events_event_path(event)

    page.execute_script "window.scrollTo(0,0)"

    assert_text 'このイベントに参加表明しました'

    assert_text '@nickname'
  end
end