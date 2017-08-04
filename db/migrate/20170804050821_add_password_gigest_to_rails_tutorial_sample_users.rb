class AddPasswordGigestToRailsTutorialSampleUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :rails_tutorial_sample_users, :password_digest, :string
  end
end
