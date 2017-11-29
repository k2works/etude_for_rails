# frozen_string_literal: true

module SalesModeling
  module Domain
    module Purchase
      class PurchaseFactory
        def initialize
          @orders_repo = SalesModeling::OrdersRepo.new
          @stocks_repo = SalesModeling::StocksRepo.new
          @warehoses_repo = SalesModeling::WarehouseRepo.new
        end

        def new_orders_repo
          @orders_repo
        end

        def new_stocks_repo
          @stocks_repo
        end

        def new_warehouses_repo
          @warehoses_repo
        end

        def new_order(params)
          @orders_repo.new_order(params)
        end

        def new_stock(params)
          @stocks_repo.new_stock(params)
        end

        def new_warehouse(params)
          @warehoses_repo.new_warehouse(params)
        end

        def new_order_strategy(order)
          return SalesModeling::Domain::Purchase::SimpleOrderStrategy.new(order) if order.order_type_category.symbol == SalesModeling::Type::SimpleOrderType::SYMBOL
          return SalesModeling::Domain::Purchase::FixSizeOrderStrategy.new(order) if order.order_type_category.symbol == SalesModeling::Type::FixSizeOrderType::SYMBOL
          return SalesModeling::Domain::Purchase::RegularOrderStrategy.new(order) if order.order_type_category.symbol == SalesModeling::Type::RegularOrderType::SYMBOL
          SalesModeling::Domain::Purchase::NullOrderStrategy.new(order)
        end
      end
    end
  end
end
