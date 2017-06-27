class AddEventImageToAwesomeEventsEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :awesome_events_events, :event_image, :string, comment:'画像用カラム'
  end
end
