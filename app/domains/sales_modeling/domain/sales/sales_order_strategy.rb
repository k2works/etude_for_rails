module SalesModeling
  module Domain
    module Sales
      class SalesOrderStrategy < SalesStrategy
        def initialize(customer)
          @customer = customer
          @factory = ApparelSalesOrderFactory.new
          @products_repo = @factory.new_product_repo
          @sales_repo = @factory.new_sales_repo
        end

        def execute
          refer_to_estimate_contents
          reserve_effective_stock
          register_sales
        end

        private

        def refer_to_estimate_contents
          @sales_estimate = @customer.sales_estimates.last
        end

        def reserve_effective_stock
          @sales_estimate.sales_lines.each do |sales_lines|
            sku = sales_lines.sales_modeling_type3_sku
          end
        end

        def register_sales
          order_type = SalesModeling::CategoryClassesRepo.select_order_category
          params = { date: Date.today, sales_type_category: order_type, sales_modeling_sales_customer: @customer }
          sales_order = @sales_repo.new_sales_order(params)
          @sales_repo.copy_sales_line(sales_order, @sales_estimate)
          @sales_repo.save(sales_order, @sales_estimate)
          sales_order
        end
      end
    end
  end
end
