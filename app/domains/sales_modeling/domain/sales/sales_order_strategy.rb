module SalesModeling
  module Domain
    module Sales
      class SalesOrderStrategy < SalesStrategy
        def initialize(customer, products)
          @customer = customer
          @product = product
          @factory = ApparelSalesOrderFactory.new
          @product_repp = @factory.new_product_repo
          @estimate_repp = @factory.new_sales_repp
        end

        def execute
          refer_to_estimate_contents
          reserve_effective_stock
          register_sales
        end

        private

        def refer_to_estimate_contents

        end

        def reserve_effective_stock

        end

        def register_sales

        end
      end
    end
  end
end
