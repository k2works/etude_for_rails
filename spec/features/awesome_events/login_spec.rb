require 'rails_helper'

describe 'ユーザがイベントの参加や登録を行うために、ログインする' do
  context 'トップページに遷移し、"Twitterでログイン"をクリックしたとき' do
    context 'かつTwitterのログインに成功したとき' do
      before do
        visit awesome_events_welcome_index_path
        click_link 'Twitterでログイン'
      end

      it 'トップページに遷移していること' do
        sleep 5
        expect(page.current_path).to eq awesome_events_welcome_index_path
      end

      it '"ログインしました"と表示されること' do
        expect(page).to have_content 'ログインしました'
      end
    end
  end
end