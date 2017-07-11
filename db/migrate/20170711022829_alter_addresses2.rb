class AlterAddresses2 < ActiveRecord::Migration[5.1]
  def change
    add_index :baukis_addresses, :postal_code, name:'baukis_addresses_postal_code'
  end
end
