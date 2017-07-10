class CreateBaukisPhones < ActiveRecord::Migration[5.1]
  def change
    create_table :baukis_phones,comment:'電話番号' do |t|
      t.references :baukis_customer, foreign_key: true, null: false ,comment:'顧客への外部キー'
      t.references :baukis_address, foreign_key: true, comment:'住所への外部キー'
      t.string :number, null:false, comment:'電話番号'
      t.string :number_for_index, null:false, comment:'索引用電話番号'
      t.boolean :primary, null:false, defaut:false, comment:'優先フラグ'

      t.timestamps
    end

    add_index :baukis_phones, :baukis_customer_id, name:'baukis_phones_customer_id'
    add_index :baukis_phones, :baukis_address_id, name:'baukis_phones_address_id'
    add_index :baukis_phones, :number_for_index, name:'baukis_phones_number_for_index'
  end
end