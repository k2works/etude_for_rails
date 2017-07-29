class CreateBaukisMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :baukis_messages, comment:'問い合わせ' do |t|
      t.references :customer, null: false                   ,comment:'顧客への外部キー'
      t.references :staff_member                            ,comment:'職員への外部キー'
      t.integer :root_id                                    ,comment:'Messageへの外部キー'
      t.integer :parent_id                                  ,comment:'Messageへの外部キー'
      t.string :type, null: false                           ,comment:'継承カラム'
      t.string :status, null: false, default: 'new'         ,comment:'状態（職員向け）'
      t.string :subject, null: false                        ,comment:'件名'
      t.text :body                                          ,comment:'本文'
      t.text :remarks                                       ,comment:'備考（職員向け）'
      t.boolean :discarded, null: false, default: false     ,comment:'顧客側の削除フラグ'
      t.boolean :deleted, null: false, default: false       ,comment:'職員側の削除フラグ'

      t.timestamps
    end

    add_index :baukis_messages, :customer_id, name:'baukis_messages_customer_id'
    add_index :baukis_messages, [ :type, :customer_id ], name:'baukis_messages_type_customer_id'
    add_index :baukis_messages, [ :customer_id, :discarded, :created_at ], name:'baukis_messages_customer_id_discarded_created_at'
    add_index :baukis_messages, :staff_member_id, name:'baukis_messages_staff_member_id'
    add_index :baukis_messages, [ :type, :staff_member_id ], name:'baukis_messages_type_staff_member_id'
    add_index :baukis_messages, [ :customer_id, :deleted, :created_at ], name:'baukis_messages_customer_id_deleted_created_at'
    add_index :baukis_messages, [ :customer_id, :deleted, :status, :created_at ], name: 'baukis_messages_custoemr_id_deleted_status_created_at'
    add_index :baukis_messages, [ :root_id, :deleted, :created_at ], name:'baukis_messages_root_id_deleted_created_at'
  end
end
