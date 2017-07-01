class CreatePerfectRailsUser2s < ActiveRecord::Migration[5.1]
  def change
    create_table :perfect_rails_user2s,comment:'ユーザ２' do |t|
      t.string :name, comment:'名前'
      t.string :prefecture, comment:'都道府県'
      t.string :city, comment:'市町村'
      t.string :house_number, comment:'番地'

      t.timestamps
    end
  end
end
