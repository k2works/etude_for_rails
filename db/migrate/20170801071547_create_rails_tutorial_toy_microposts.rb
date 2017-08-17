class CreateRailsTutorialToyMicroposts < ActiveRecord::Migration[5.1]
  def change
    create_table :rails_tutorial_toy_microposts,comment:'マイクロポスト' do |t|
      t.text :content, comment:'内容'
      t.integer :user_id, comment:'ユーザID'

      t.timestamps
    end
  end
end
