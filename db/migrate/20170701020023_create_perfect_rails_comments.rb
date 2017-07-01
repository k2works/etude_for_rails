class CreatePerfectRailsComments < ActiveRecord::Migration[5.1]
  def change
    create_table :perfect_rails_comments do |t|
      t.datetime :published_at

      t.timestamps
    end
  end
end
