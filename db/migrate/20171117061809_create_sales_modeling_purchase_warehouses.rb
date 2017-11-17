class CreateSalesModelingPurchaseWarehouses < ActiveRecord::Migration[5.1]
  def change
    create_table :sales_modeling_purchase_warehouses, comment:'倉庫' do |t|
      t.string :code, comment:'コード'
      t.string :name, comment:'名前'
      t.references :sales_modeling_purchase_orders, comment:'発注', foreign_key: true, index: {name:'index_sales_modeling_purchase_warehouses_order_id'}
      t.references :sales_modeling_purchase_stocks, comment:'入庫', foreign_key: true, index: {name:'index_sales_modeling_purchase_warehouses_stock_id'}
      t.references :warehouse_type_category, comment:'倉庫区分',index: {name:'index_sales_modeling_purchase_warehouse_category_id'}

      t.timestamps
    end
  end
end
