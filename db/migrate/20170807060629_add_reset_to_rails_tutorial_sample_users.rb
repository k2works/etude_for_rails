class AddResetToRailsTutorialSampleUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :rails_tutorial_sample_users, :reset_digest, :string, comment:'リセットダイジェスト'
    add_column :rails_tutorial_sample_users, :reset_sent_at, :datetime, comment:'リセット送信日'
  end
end
