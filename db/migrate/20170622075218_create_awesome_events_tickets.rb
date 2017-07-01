class CreateAwesomeEventsTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :awesome_events_tickets, comment:'チケット' do |t|
      t.references :awesome_events_user, foreign_key: true, comment:'ユーザID'
      t.references :awesome_events_event, foreign_key: true, comment:'イベントID'
      t.string :comment, comment:'コメント'

      t.timestamps
    end

    add_index :awesome_events_tickets, [:awesome_events_user_id, :awesome_events_event_id], unique: true, name: 'by_user_id_event_id'
    add_index :awesome_events_tickets, [:awesome_events_event_id, :awesome_events_user_id], unique: true, name: 'by_event_id_user_id'
  end
end
