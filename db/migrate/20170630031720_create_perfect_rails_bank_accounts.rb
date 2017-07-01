class CreatePerfectRailsBankAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :perfect_rails_bank_accounts do |t|
      t.string :credit_card_number

      t.timestamps
    end
  end
end
