class CreateSalesModelingType2Products < ActiveRecord::Migration[5.1]
  def change
    create_table :sales_modeling_type2_products,comment:'商品' do |t|
      t.string :code, comment:'商品コード'
      t.string :name, comment:'商品名'
      t.references :size, comment:'サイズ'
      t.references :color, comment:'色'
      t.references :product_category, comment:'製品区分'
      t.decimal :unit_purchase_price_amount, comment:'仕入単価'
      t.string :unit_purchase_price_currency, comment:'仕入単価通貨'
      t.decimal :unit_sales_price_amount, comment:'販売単価'
      t.string :unit_sales_price_currency, comment:'販売単価通貨'

      t.timestamps
    end
  end
end
