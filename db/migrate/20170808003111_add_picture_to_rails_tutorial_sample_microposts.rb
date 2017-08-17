class AddPictureToRailsTutorialSampleMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :rails_tutorial_sample_microposts, :picture, :string, comment:'画像'
  end
end
