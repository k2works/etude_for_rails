# frozen_string_literal: true

module SalesModeling
  module Domain
    module Purchase
      class OrderService
        def simple_order(params)
          repos = SalesModeling::OrderRepo.new
          order = repos.new_order(params)
          repos.save_order(order) if order.order_type_category.symbol == SalesModeling::Type::SimpleOrderType::SYMBOL
        end

        def regular_order(params)
          repos = SalesModeling::OrderRepo.new
          order = repos.new_order(params)
          repos.save_order(order) if order.order_type_category.symbol == SalesModeling::Type::RegularOrderType::SYMBOL
        end

        def fix_size_order(params)
          repos = SalesModeling::OrderRepo.new
          order = repos.new_order(params)
          repos.save_order(order) if order.order_type_category.symbol == SalesModeling::Type::FixSizeOrderType::SYMBOL
        end
      end
    end
  end
end
