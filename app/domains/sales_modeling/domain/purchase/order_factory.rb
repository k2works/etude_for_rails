# frozen_string_literal: true

module SalesModeling
  module Domain
    module Purchase
      class OrderFactory
        def initialize
          @repos = SalesModeling::OrderRepo.new
        end

        def new_repos
          @repos
        end

        def new_order(params)
          @repos.new_order(params)
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
