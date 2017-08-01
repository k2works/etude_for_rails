class CreateBaukisHashLocks < ActiveRecord::Migration[5.1]
  def change
    create_table :baukis_hash_locks, comment:'排他制御' do |t|
      t.string :table, null: false, comment: 'テーブル'
      t.string :column, null: false, comment: 'カラム'
      t.string :key, null: false, comment: 'キー'

      t.timestamps
    end
  end
end
