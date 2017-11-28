# frozen_string_literal: true

module SalesModeling
  module Domain
    module Purchase
      class OrderService
        def simple_order(params)
          repos = SalesModeling::OrderRepo.new
          order = repos.new_order(params)
          repos.save_order(order) if order.order_type_category.name == '簡易'
        end

        def regular_order(params)
          repos = SalesModeling::OrderRepo.new
          order = repos.new_order(params)
          repos.save_order(order) if order.order_type_category.name == '定期'
        end

        def fix_size_order(params)
          repos = SalesModeling::OrderRepo.new
          order = repos.new_order(params)
          repos.save_order(order) if order.order_type_category.name == '定量'
        end
      end
    end
  end
end
