class CreateRailsTutorialToyUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :rails_tutorial_toy_users,comment:'ユーザー' do |t|
      t.string :name, comment:'名前'
      t.string :email, comment:'メールアドレス'

      t.timestamps
    end
  end
end
