class CreateBaukisAdministrators < ActiveRecord::Migration[5.1]
  def change
    create_table :baukis_administrators, comment:'管理者' do |t|
      t.string :email, null:false, comment:'メールアドレス'
      t.string :email_for_index, null:false, comment:'索引用メールアドレス'
      t.string :hashed_password, comment:'パスワード'
      t.boolean :suspended, null:false, default:false, comment:'停止フラグ'

      t.timestamps
    end

    add_index :baukis_administrators, :email_for_index, unique: true, name:'baukis_administrators_email'
  end
end
