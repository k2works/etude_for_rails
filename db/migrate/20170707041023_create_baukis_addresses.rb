class CreateBaukisAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :baukis_addresses,comment:'住所' do |t|
      t.references :baukis_customer, foreign_key: true, null: false ,comment:'顧客への外部キー'
      t.string :type, null: false                           ,comment:'継承カラム'
      t.string :postal_code, null: false                    ,comment:'郵便番号'
      t.string :prefecture, null: false                     ,comment:'都道府県'
      t.string :city, null: false                           ,comment:'市区町村'
      t.string :address1, null: false                       ,comment:'町域、番地等'
      t.string :address2, null: false                       ,comment:'建物名、部屋番号等'
      t.string :company_name, null: false, default: ''      ,comment:'会社名'
      t.string :division_name, null: false, default: ''     ,comment:'部署名'

      t.timestamps null: false
    end

    add_index :baukis_addresses, :baukis_customer_id, name:'baukis_addresses_customer_id'
    add_index :baukis_addresses, [ :type, :baukis_customer_id], unique: true, name:'baukis_addresses_type_customer_id'
  end
end
