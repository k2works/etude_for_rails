# frozen_string_literal: true

module SalesModeling
  module Domain
    module Purchase
      module Order
        def price
          @price ||= SalesModeling::Price::OrderPrice.new(amount)
        end

        def price=(price)
          self.amount = price.amount
          self.currency = price.currency
        end
      end
    end
  end
end
