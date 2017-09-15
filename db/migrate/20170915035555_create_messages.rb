class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages, comment:'ジョブメッセージ' do |t|
      t.text :body, comment:'本文'

      t.timestamps
    end
  end
end
