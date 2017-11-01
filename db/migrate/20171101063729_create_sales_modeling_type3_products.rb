class CreateSalesModelingType3Products < ActiveRecord::Migration[5.1]
  def change
    create_table :sales_modeling_type3_products, comment:'商品' do |t|
      t.string :code, comment:'商品コード'
      t.string :name, comment:'商品名'
      t.references :product_type_category, comment:'製品区分', index: {name:'index_type3_product_type_category_id'}
      t.references :brand_category, comment:'ブランド', index: {name:'index_type3_brand_category_id'}
      t.references :season_category, comment:'シーズン', index: {name:'index_type3_season_category_id'}
      t.references :year_category, comment:'年度', index: {name:'index_type3_year_category_id'}

      t.timestamps
    end
  end
end
