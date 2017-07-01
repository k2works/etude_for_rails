class CreateAwesomeEventsEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :awesome_events_events,comment:'イベント' do |t|
      t.integer :owner_id,                comment:'イベントを作成したユーザのID'
      t.string :name,         null:false, comment:'イベントの名前'
      t.string :place,        null:false, comment:'イベントの開催場所'
      t.datetime :start_time, null:false, comment:'イベント開始時間'
      t.datetime :end_time,   null:false, comment:'イベント終了時間'
      t.text :content,        null:false, comment:'イベントの詳細'

      t.timestamps
    end
  end
end
