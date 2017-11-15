module SalesModeling
  module Domain
    module Sales
      class SalesService
        def present_estimate(customer, products)
          estimate = SalesEstimateStrategy.new(customer, products)
          estimate.execute
        end

        def accept_orders(customer, products)
          order_sales = SalesOrderStrategy.new(customer, products)
          order_sales.execute
        end
      end
    end
  end
end
