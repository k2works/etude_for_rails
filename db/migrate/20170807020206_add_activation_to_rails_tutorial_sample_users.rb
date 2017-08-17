class AddActivationToRailsTutorialSampleUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :rails_tutorial_sample_users, :activation_digest, :string, comment:'認証ダイジェスト'
    add_column :rails_tutorial_sample_users, :activated, :boolean, default:false, comment:'認証フラグ'
    add_column :rails_tutorial_sample_users, :activated_at, :datetime, comment:'認証日'
  end
end
