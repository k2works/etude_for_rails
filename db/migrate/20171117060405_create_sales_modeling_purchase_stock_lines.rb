class CreateSalesModelingPurchaseStockLines < ActiveRecord::Migration[5.1]
  def change
    create_table :sales_modeling_purchase_stock_lines,comment:'入庫明細' do |t|
      t.integer :line_number, comment:'行番号'
      t.decimal :quantity_amount, comment:'数量'
      t.string :quantity_unit, comment:'単位'
      t.decimal :unit_price_amount, comment:'発注単価'
      t.string :unit_price_currency, comment:'通貨'
      t.decimal :price_amount, comment:'発注金額'
      t.string :price_currency, comment:'通貨'
      t.references :sales_modeling_purchase_stocks, comment:'入庫', foreign_key: true, index: {name:'index_sales_modeling_purchase_stock_line_id'}
      t.references :sales_modeling_type3_sku,comment:'ストックキーピングユニット', foreign_key: true, index: {name:'index_sales_modeling_purchase_stock_line_on_sku_id'}

      t.timestamps
    end
  end
end
