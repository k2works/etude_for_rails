class CreateSalesModelingType2CategoryClasses < ActiveRecord::Migration[5.1]
  def change
    create_table :sales_modeling_type2_category_classes, comment:'分類種別' do |t|
      t.string :code, comment:'コード'
      t.string :name, comment:'分類種別名'

      t.timestamps
    end
  end
end
