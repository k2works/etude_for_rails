class CreateRailsTutorialSampleUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :rails_tutorial_sample_users,comment:'ユーザ' do |t|
      t.string :name, comment:'名前'
      t.string :emial, comment:'メールアドレス'

      t.timestamps
    end
  end
end
