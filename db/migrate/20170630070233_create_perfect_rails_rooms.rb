class CreatePerfectRailsRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :perfect_rails_rooms do |t|

      t.timestamps
    end
  end
end
