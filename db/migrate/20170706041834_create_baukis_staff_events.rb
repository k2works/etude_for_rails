class CreateBaukisStaffEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :baukis_staff_events,comment:'イベント' do |t|
      t.references :baukis_staff_member, foreign_key: true, null:false, comment:'職員レコードへの外部キー'
      t.string :event_type, null:false, comment:'イベントタイプ'
      t.datetime :created_at, null:false, comment:'発生時刻'

      t.timestamps
    end

    add_index :baukis_staff_events, :created_at, name:'baukis_staff_events_created_at'
    add_index :baukis_staff_events, [ :baukis_staff_member_id, :created_at ], name:'baukis_staff_events_member_id_created_at'
  end
end
