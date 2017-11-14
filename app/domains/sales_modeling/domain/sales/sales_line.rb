module SalesModeling
  module Domain
    module Sales
      module SalesLine
        attr_reader :quantity,
                    :unit_sales_price,
                    :sales_price

        def quantity=(params)
          @quantity = SalesModeling::Quantity.new(params[:amount], params[:unit]) unless params.nil?
        end

        def unit_sales_price=(amount)
          @unit_sales_price = SalesModeling::Price::UnitSalesPrice.new(amount)
        end

        def sales_price=(amount)
          @sales_price = SalesModeling::Price::SalesPrice.new(amount)
        end
      end
    end
  end
end
