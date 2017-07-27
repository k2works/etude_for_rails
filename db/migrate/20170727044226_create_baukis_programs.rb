class CreateBaukisPrograms < ActiveRecord::Migration[5.1]
  def change
    create_table :baukis_programs, comment:'プログラム' do |t|
      t.references :registrant, null: false           ,comment:'登録職員（外部キー）'
      t.string :title, null: false                    ,comment:'タイトル'
      t.text :description                             ,comment:'説明'
      t.datetime :application_start_time, null: false ,comment:'申し込み開始日時'
      t.datetime :application_end_time, null: false   ,comment:'申し込み終了日時'
      t.integer :min_number_of_participants           ,comment:'最小参加者数'
      t.integer :max_number_of_participants           ,comment:'最大参加者数'

      t.timestamps
    end

    add_index :baukis_programs, :registrant_id, name:'baukis_programs_registrant_id'
    add_index :baukis_programs, :application_start_time, name:'baukis_programs_application_start_time'
  end
end
