# frozen_string_literal: true

module SalesModeling
  module Domain
    module Sales
      class SalesEstimateStrategy < SalesStrategy
        def initialize(customer, product)
          @customer = customer
          @product = product
          @factory = ApparelSalesEstimateFactory.new
          @product_repp = @factory.new_product_repo
          @estimate_repp = @factory.new_sales_repp
        end

        def execute
          check_inventory
          create_estimate
        end

        private

        def check_inventory

        end

        def create_estimate

        end
      end
    end
  end
end
