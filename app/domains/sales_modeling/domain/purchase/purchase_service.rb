# frozen_string_literal: true

module SalesModeling
  module Domain
    module Purchase
      class PurchaseService
        def initialize
          @factory = PurchaseFactory.new
          @orders_repo = @factory.new_orders_repo
          @stocks_repo = @factory.new_stocks_repo
          @warehouses_repo = @factory.new_warehouses_repo
        end

        def order_to_supplier(params)
          order = @factory.new_order(params)
          order.strategy = @factory.new_order_strategy(order)
          order.execute
          @orders_repo.save_order(order)
        end

        def acceptance_inspection(stock_params, warehosue_params)
          stock = @factory.new_stock(stock_params)
          @stocks_repo.save_stock(stock)

          warehouse = @factory.new_warehouse(warehosue_params)
          warehouse.sales_modeling_purchase_stock = stock
          @warehouses_repo.save_warehouse(warehouse)
        end
      end
    end
  end
end
