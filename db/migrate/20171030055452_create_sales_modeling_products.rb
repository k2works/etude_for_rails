class CreateSalesModelingProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :sales_modeling_products, comment:'商品' do |t|
      t.string :code, comment:'商品コード'
      t.string :name, comment:'商品名'
      t.references :sales_modeling_size, foreign_key: true, index: {name:'index_sales_modeling_on_size_id'}
      t.references :sales_modeling_color, foreign_key: true, index: {name:'index_sales_modeling_on_color_id'}
      t.references :sales_modeling_product_category, foreign_key: true, index: {name:'index_sales_modeling_on_product_category_id'}
      t.decimal :unit_purchase_price, comment:'仕入単価'
      t.decimal :unit_sales_price, comment:'販売単価'

      t.timestamps
    end
  end
end
