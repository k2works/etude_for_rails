# frozen_string_literal: true

module SalesModeling
  module Domain
    module Purchase
      module OrderLine
        def unit_price
          @unit_price ||= SalesModeling::Price::UnitOrderPrice.new(unit_price_amount)
        end

        def unit_price=(price)
          self.unit_price_amount = price.amount
          self.unit_price_currency = price.currency
        end

        def price
          @price ||= calculate_price
        end

        def price=(price)
          self.price_amount = price.amount
          self.price_currency = price.currency
        end

        def quantity
          @quantity ||= SalesModeling::Quantity.new(quantity_amount, quantity_unit)
        end

        def quantity=(quantity)
          self.quantity_amount = quantity.amount
          self.quantity_unit = quantity.unit
        end

        private

        def calculate_price
          unit_price.*(quantity)
        end
      end
    end
  end
end
