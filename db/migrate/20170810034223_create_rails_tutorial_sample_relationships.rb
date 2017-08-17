class CreateRailsTutorialSampleRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :rails_tutorial_sample_relationships ,comment:'関係' do |t|
      t.integer :follower_id ,comment:'フォロー'
      t.integer :followed_id ,comment:'フォロワー'

      t.timestamps
    end
    add_index :rails_tutorial_sample_relationships, :follower_id, name:'index_rails_tutorial_sample_relationships_on_follower'
    add_index :rails_tutorial_sample_relationships, :followed_id, name:'index_rails_tutorial_sample_relationships_on_followed'
    add_index :rails_tutorial_sample_relationships, [:follower_id, :followed_id], unique: true, name: 'index_rails_tutorial_sample_relationships_on_follow_followed'
  end
end
