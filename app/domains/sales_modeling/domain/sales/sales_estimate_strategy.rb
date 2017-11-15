# frozen_string_literal: true

module SalesModeling
  module Domain
    module Sales
      class SalesEstimateStrategy < SalesStrategy
        def initialize(customer, products)
          @customer = customer
          @estimates = products
          @factory = ApparelSalesEstimateFactory.new
          @products_repo = @factory.new_product_repo
          @estimate_repo = @factory.new_sales_repo
          @estimate = @estimate_repo.new_sales_estimate
        end

        def execute
          check_inventory
          create_estimate
        end

        private

        def check_inventory

        end

        def create_estimate
          estimate_type = SalesModeling::CategoryClassesRepo.select_etimate_category
          params = { date: Date.today, sales_type_category: estimate_type, sales_modeling_sales_customer: @customer }
          sales_estimate = @estimate_repo.new_sales_estimate(params)
          @estimates.each do |estimate|
            product = @products_repo.select_by_sku_code(estimate[:sku_code])
            quantity = SalesModeling::Quantity.new(estimate[:amount].to_i, estimate[:unit])
            @estimate_repo.new_sales_line(sales_estimate, product, quantity)
          end
          @estimate_repo.save(sales_estimate)
          sales_estimate
        end
      end
    end
  end
end
