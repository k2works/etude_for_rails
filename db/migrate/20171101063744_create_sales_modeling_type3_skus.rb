class CreateSalesModelingType3Skus < ActiveRecord::Migration[5.1]
  def change
    create_table :sales_modeling_type3_skus, comment:'ストックキーピングユニット' do |t|
      t.string :code, comment:'SKUコード'
      t.decimal :unit_purchase_price_amount, comment:'仕入単価'
      t.string :unit_purchase_price_currency, comment:'仕入単価通貨'
      t.decimal :unit_sales_price_amount, comment:'販売単価'
      t.string :unit_sales_price_currency, comment:'販売単価通貨'
      t.references :sales_modeling_type3_product, comment:'商品', foreign_key: true, index: {name:'index_sales_modeling_type3_on_product_id'}
      t.references :size_category, comment:'サイズ', index: {name:'index_type3_size_category_id'}
      t.references :color_category, comment:'色', index: {name:'index_type3_color_category_id'}

      t.timestamps
    end
  end
end
