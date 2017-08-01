class CreateBaukisTags < ActiveRecord::Migration[5.1]
  def change
    create_table :baukis_tags, comment:'タグ' do |t|
      t.string :value, null: false, comment:'値'
    end

    add_index :baukis_tags, :value, unique: true
  end
end
