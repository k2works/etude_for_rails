class CreateRailsTutorialSampleMicroposts < ActiveRecord::Migration[5.1]
  def change
    create_table :rails_tutorial_sample_microposts,comment:'マイクロポスト' do |t|
      t.text :content,comment:'内容'
      t.references :rails_tutorial_sample_user, foreign_key: true, index: {name:'index_rails_tutorial_sample_micropost_on_user_id'}

      t.timestamps
    end
    add_index :rails_tutorial_sample_microposts, [:rails_tutorial_sample_user_id,:created_at], name:'index_rails_tutorial_sample_micropost_on_user_id_created_at'
  end
end
