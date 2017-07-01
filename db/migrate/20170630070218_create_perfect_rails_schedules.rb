class CreatePerfectRailsSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :perfect_rails_schedules do |t|
      t.integer :room_id
      t.datetime :finished_at
      t.datetime :started_at

      t.timestamps
    end
  end
end
