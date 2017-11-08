class CreateSalesModelingSalesEstimates < ActiveRecord::Migration[5.1]
  def change
    create_table :sales_modeling_sales_estimates,comment:'見積' do |t|
      t.references :sales_estimate, comment:'見積'
      t.references :sales_order,comment:'注文'

      t.timestamps
    end
  end
end
