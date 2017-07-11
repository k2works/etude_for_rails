class AlterCustomers2 < ActiveRecord::Migration[5.1]
  def change
    add_index :baukis_customers, [ :gender, :family_name_kana, :given_name_kana], name: 'baukis_customers_on_gender_and_furigana'
  end
end
