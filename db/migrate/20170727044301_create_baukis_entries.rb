class CreateBaukisEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :baukis_entries,comment:'申し込み' do |t|
      t.references :program, null: false
      t.references :customer, null: false
      t.boolean :approved, null: false, default: false ,comment:'承認済みフラグ'
      t.boolean :canceled, null: false, default: false ,comment:'取り消しフラグ'

      t.timestamps
    end

    add_index :baukis_entries, [ :program_id, :customer_id ], unique: true, name:'baukis_entries_program_id_customer_id'
    add_index :baukis_entries, :customer_id, name:'baukis_entries_customer_id'
  end
end
