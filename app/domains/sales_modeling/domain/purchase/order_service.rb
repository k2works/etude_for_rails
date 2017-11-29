# frozen_string_literal: true

module SalesModeling
  module Domain
    module Purchase
      class OrderService
        def order_to_supplier(params)
          factory = OrderFactory.new
          order = factory.new_order(params)
          strategy = factory.new_order_strategy(order)
          order = strategy.execute
          repos = factory.new_repos
          repos.save_order(order)
        end

        def acceptance_inspection(stock_params, warehosue_params)
          factory = OrderFactory.new
          stock = factory.new_stock(stock_params)
          stock_repos = factory.new_stocks_repo
          stock_repos.save_stock(stock)

          warehouse = factory.new_warehouse(warehosue_params)
          warehouse.sales_modeling_purchase_stock = stock
          warehouse_repos = factory.new_warehouses_repo
          warehouse_repos.save_warehouse(warehouse)
        end
      end
    end
  end
end
