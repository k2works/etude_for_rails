require 'rails_helper'

describe 'ユーザがイベント参加表明をする' do
  let!(:event) { create :event }

  context 'ログインユーザが、イベント詳細ページで"参加する"をクリックしたとき' do
    before do
      visit awesome_events_welcome_index_path
      click_link 'Twitterでログイン'
      visit awesome_events_event_path(event)
      click_on '参加する'
    end

    it 'コメント入力用のモーダルウィンドウが表示されていること' do
      expect(page.find('#createTicket')).to be_visible
    end

    context 'かつ、コメントを入力し"送信"ボタンをおしたとき' do
      before do
        fill_in 'awesome_events_ticket[comment]', with: '参加します!'
        click_button '送信'
        visit awesome_events_event_path(event)
      end

      it '"このイベントに参加表明しました"と表示されていること' do
        expect(page).to have_content('このイベントに参加表明しました')
      end

      it '参加表明したユーザ名が表示されていること' do
        pending("テストDBをMySQLに変更してから発生")
        expect(page).to have_content('@nickname')
      end
    end
  end
end
