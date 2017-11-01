class CreateSalesModelingType3Categories < ActiveRecord::Migration[5.1]
  def change
    create_table :sales_modeling_type3_categories, comment:'分類' do |t|
      t.string :code, comment:'コード'
      t.string :name, comment:'分類名'
      t.references :sales_modeling_type3_category_class, foreign_key: true, index: {name:'index_sales_modeling_type3_on_category_class_id'}
      t.references :parent_category, comment:'親カテゴリ'

      t.timestamps
    end
  end
end
