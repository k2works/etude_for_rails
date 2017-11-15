module SalesModeling
  module Domain
    module Sales
      class SalesService
        def present_estimate(customer, product)
          estimate = SalesEstimateStrategy.new(customer, product)
          estimate.execute
        end

        def accept_orders(customer, product)
          order_sales = SalesOrderStrategy.new(customer, product)
          order_sales.execute
        end
      end
    end
  end
end
