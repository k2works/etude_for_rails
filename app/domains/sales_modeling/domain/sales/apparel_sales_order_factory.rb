# frozen_string_literal: true

module SalesModeling
  module Domain
    module Sales
      class ApparelSalesOrderFactory < SalesFactory
        def initialize
          @products_repo = SalesModeling::ProductsRepo.new
          @sales_repo = SalesModeling::SalesRepo.new
        end

        def new_product_repo
          @products_repo
        end

        def new_sales_repo
          @sales_repo
        end
      end
    end
  end
end
