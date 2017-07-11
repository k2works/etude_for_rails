class CreateBaukisAllowedSources < ActiveRecord::Migration[5.1]
  def change
    create_table :baukis_allowed_sources,comment:'許可IPアドレス' do |t|
      t.string :namespace, null: false, comment:'名前空間'
      t.integer :octet1, null: false, comment:'第１オクテット'
      t.integer :octet2, null: false, comment:'第２オクテット'
      t.integer :octet3, null: false, comment:'第３オクテット'
      t.integer :octet4, null: false, comment:'第４オクテット'
      t.boolean :wildcard, null: false, default: false, comment:'ワイルドカード'

      t.timestamps
    end

    add_index :baukis_allowed_sources, [ :namespace, :octet1, :octet2, :octet3, :octet4 ], unique: true, name: 'baukis_allowed_sources_on_namespace_and_octets'
  end
end
