class CreateSalesModelingColors < ActiveRecord::Migration[5.1]
  def change
    create_table :sales_modeling_colors,comment:'カラー' do |t|
      t.string :code, comment:'コード'
      t.string :name, comment:'名前'

      t.timestamps
    end
  end
end
