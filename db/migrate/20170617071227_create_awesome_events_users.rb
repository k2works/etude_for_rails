class CreateAwesomeEventsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :awesome_events_users,comment:'ログインユーザ' do |t|
      t.string :provider, comment:'プロバイダ名'
      t.string :uid, comment:'ブロバイダ別ユーザ識別子'
      t.string :nickname, comment:'TwitterID'
      t.string :image_url, comment:'Twitterアイコン画像URL'

      t.timestamps
    end
  end
end
