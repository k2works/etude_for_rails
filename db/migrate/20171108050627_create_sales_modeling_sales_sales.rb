class CreateSalesModelingSalesSales < ActiveRecord::Migration[5.1]
  def change
    create_table :sales_modeling_sales_sales,comment:'売上' do |t|
      t.string :type ,comment:'STIカラム'
      t.datetime :date, comment:'売上日'
      t.decimal :amount, comment:'金額'
      t.string :currency, comment:'通貨'
      t.references :sales_modeling_sales_customer, comment:'顧客', foreign_key: true, index: {name:'index_sales_modeling_sales_on_customer_id'}
      t.references :sales_type_category, comment:'売上区分', index: {name:'index_sales_modeling_sales_sales_category_id'}

      t.timestamps
    end
  end
end
