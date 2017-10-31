class CreateSalesModelingType1Products < ActiveRecord::Migration[5.1]
  def change
    create_table :sales_modeling_type1_products, comment:'商品' do |t|
      t.string :code, comment:'商品コード'
      t.string :name, comment:'商品名'
      t.references :sales_modeling_type1_size, foreign_key: true, index: {name:'index_sales_modeling_type1_on_size_id'}
      t.references :sales_modeling_type1_color, foreign_key: true, index: {name:'index_sales_modeling_type1_on_color_id'}
      t.references :sales_modeling_type1_product_category, foreign_key: true, index: {name:'index_sales_modeling_type1_on_product_category_id'}
      t.decimal :unit_purchase_price_amount, comment:'仕入単価'
      t.string :unit_purchase_price_currency, comment:'仕入単価通貨'
      t.decimal :unit_sales_price_amount, comment:'販売単価'
      t.string :unit_sales_price_currency, comment:'販売単価通貨'

      t.timestamps
    end
  end
end
