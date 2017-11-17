# frozen_string_literal: true

class CreateSalesModelingPurchaseOrderLines < ActiveRecord::Migration[5.1]
  def change
    create_table :sales_modeling_purchase_order_lines, comment: '発注明細' do |t|
      t.integer :line_number, comment: '明細番号'
      t.decimal :quantity_amount, comment: '数量'
      t.string :quantity_unit, comment: '単位'
      t.decimal :unit_price_amount, comment: '発注単価'
      t.string :unit_price_currency, comment: '通貨'
      t.decimal :price_amount, comment: '発注金額'
      t.string :price_currency, comment: '通貨'
      t.references :sales_modeling_purchase_orders, comment: '発注', foreign_key: true, index: { name: 'index_sales_modeling_purchase_order_line_id' }
      t.references :sales_modeling_type3_sku, comment: 'ストックキーピングユニット', foreign_key: true, index: { name: 'index_sales_modeling_purchase_order_line_on_sku_id' }

      t.timestamps
    end
  end
end
