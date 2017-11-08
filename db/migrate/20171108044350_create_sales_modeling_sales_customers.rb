class CreateSalesModelingSalesCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :sales_modeling_sales_customers, comment:'顧客' do |t|
      t.string :code, comment:'コード'
      t.string :name, comment:'名称'
      t.string :prefecture, comment:'都道府県'
      t.string :city, comment:'市町村'
      t.string :house_number, comment:'番地'
      t.string :telephone_number, comment:'電話番号'
      t.references :customer_type_category, comment:'顧客区分', index: {name:'index_sales_modeling_salse_customer_category_id'}

      t.timestamps
    end
  end
end
