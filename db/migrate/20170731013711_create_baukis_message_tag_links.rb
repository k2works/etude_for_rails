class CreateBaukisMessageTagLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :baukis_message_tag_links,comment:'メッセージタグリンク' do |t|
      t.references :message, null: false, comment:'メッセージへの外部キー'
      t.references :tag, null: false, comment:'タグへの外部キー'
    end

    add_index :baukis_message_tag_links, [ :message_id, :tag_id ], unique: true, name:'baukis_message_tag_links_message_id_tag_id'
  end
end
