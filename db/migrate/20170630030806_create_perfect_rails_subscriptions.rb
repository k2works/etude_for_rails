class CreatePerfectRailsSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :perfect_rails_subscriptions do |t|
      t.date :signed_up_on

      t.timestamps
    end
  end
end
