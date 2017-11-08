class CreateSalesModelingSalesSalesLines < ActiveRecord::Migration[5.1]
  def change
    create_table :sales_modeling_sales_sales_lines, comment:'売上明細' do |t|
      t.integer :line_number, comment:'明細番号'
      t.decimal :quantity_amount, comment:'数量'
      t.string :quantity_unit, comment:'単位'
      t.decimal :unit_sales_price_amount, comment:'販売単価'
      t.string :unit_sales_price_currency, comment:'販売単価通貨'
      t.decimal :sales_price_amount, comment:'金額'
      t.string :sales_price_amount_currency, comment:'通貨'
      t.references :sales_modeling_sales_sales,comment:'売上', foreign_key: true, index: {name:'index_sales_modeling_sales_on_sales_id'}
      t.references :sales_modeling_type3_sku,comment:'ストックキーピングユニット', foreign_key: true, index: {name:'index_sales_modeling_type3_on_sku_id'}

      t.timestamps
    end
  end
end
