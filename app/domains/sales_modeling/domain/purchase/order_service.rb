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
      end
    end
  end
end
