class CreateSalesModelingPurchaseStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :sales_modeling_purchase_stocks,comment:'入庫' do |t|
      t.datetime :arrival_date, comment:'入庫日付'
      t.datetime :acceptance_date, comment:'検収日付'
      t.references :sales_modeling_purchase_suppliers, comment: '仕入先', foreign_key: true, index: {name:'index_sales_modeling_purchase_stock_supplier_id'}
      t.references :stock_type_category_code, comment:'入庫区分',index: {name:'index_sales_modeling_purchase_stock_category_id'}

      t.timestamps
    end
  end
end
