class CreatePerfectRailsAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :perfect_rails_accounts,comment:'口座' do |t|
      t.integer :amount,comment:'金額'
      t.string :currency,comment:'通貨'

      t.timestamps
    end
  end
end
