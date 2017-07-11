class AlterAddresses1 < ActiveRecord::Migration[5.1]
  def change
    add_index :baukis_addresses, [ :type, :prefecture, :city ], name:'baukis_addresses_type_prefecture_city'
    add_index :baukis_addresses, [ :type, :city ], name:'baukis_addresses_type_city'
    add_index :baukis_addresses, [ :prefecture, :city ], name:'baukis_addresses_prefecture_city'
    add_index :baukis_addresses, :city,name:'baukis_addresses_city'
  end
end
