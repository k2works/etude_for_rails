class AlterCustomer1 < ActiveRecord::Migration[5.1]
  def change
    add_column :baukis_customers, :birth_year, :integer,comment:'誕生年'
    add_column :baukis_customers, :birth_month, :integer,comment:'誕生月'
    add_column :baukis_customers, :birth_mday, :integer,comment:'誕生日'

    add_index :baukis_customers, [ :birth_year, :birth_month, :birth_mday ], name: 'baukis_customers_birth_year_month_day'
    add_index :baukis_customers, [ :birth_month, :birth_mday ], name: 'baukis_customers_birth_month_day'
    add_index :baukis_customers, :given_name_kana, name: 'baukis_customers_name_kana'
    add_index :baukis_customers, [ :birth_year, :family_name_kana, :given_name_kana ], name: 'baukis_customers_on_birth_year_and_furigana'
    add_index :baukis_customers, [ :birth_month, :family_name_kana, :given_name_kana ], name: 'baukis_customers_on_birth_month_and_furigana'
    add_index :baukis_customers, [ :birth_mday, :family_name_kana, :given_name_kana], name: 'baukis_customers_on_birth_mday_and_furigana'
    add_index :baukis_customers, [ :birth_mday, :given_name_kana ], name:'baukis_customers_biarth_day_name_kana'
  end
end
