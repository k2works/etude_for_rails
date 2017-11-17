class CreateSalesModelingPurchaseOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :sales_modeling_purchase_orders, comment:'発注' do |t|
      t.datetime :order_date, comment: '発注日'
      t.datetime :scheduled_arrival_date, comment: '入荷予定日'
      t.decimal :amount, comment: '金額'
      t.string :currency, comment: '通貨'
      t.references :sales_modeling_purchase_suppliers, comment: '仕入先', foreign_key: true, index: {name:'index_sales_modeling_purchase_order_supplier_id'}
      t.references :order_type_category_code, comment:'発注区分',index: {name:'index_sales_modeling_purchase_order_category_id'}

      t.timestamps
    end
  end
end
