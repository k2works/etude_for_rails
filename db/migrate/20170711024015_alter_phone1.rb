class AlterPhone1 < ActiveRecord::Migration[5.1]
  def change
    add_column :baukis_phones, :last_four_digits, :string, comment:'電話番号下４桁'
    add_index :baukis_phones, :last_four_digits, name:'baukis_phones_last_four_digits'
  end
end
