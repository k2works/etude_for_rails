class CreateBaukisCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :baukis_customers, comment:'顧客' do |t|
      t.string :email, null: false             ,comment:'メールアドレス'
      t.string :email_for_index, null: false   ,comment:'索引用メールアドレス'
      t.string :family_name, null: false       ,comment:'姓'
      t.string :given_name, null: false        ,comment:'名'
      t.string :family_name_kana, null: false  ,comment:'姓（カナ）'
      t.string :given_name_kana, null: false   ,comment:'名（カナ）'
      t.string :gender                         ,comment:'性別'
      t.date :birthday                         ,comment:'誕生日'
      t.string :hashed_password                ,comment:'パスワード'

      t.timestamps
    end

    add_index :baukis_customers, :email_for_index, unique: true, name: 'baukis_customers_email_for_index'
    add_index :baukis_customers, [ :family_name_kana, :given_name_kana ], name:'baukis_customers_nanme_kana'
  end
end
