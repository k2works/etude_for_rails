class AddIndexToRailsTutorialSampleUsersEmail < ActiveRecord::Migration[5.1]
  def change
    add_index :rails_tutorial_sample_users, :email, unique:true
  end
end
