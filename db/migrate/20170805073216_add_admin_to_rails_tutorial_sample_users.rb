class AddAdminToRailsTutorialSampleUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :rails_tutorial_sample_users, :admin, :boolean, default:false, comment:'管理者フラグ'
  end
end
