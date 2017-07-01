class CreatePerfectRailsCreditCards < ActiveRecord::Migration[5.1]
  def change
    create_table :perfect_rails_credit_cards do |t|
      t.string :number

      t.timestamps
    end
  end
end
