# frozen_string_literal: true

module SalesModeling
  module Domain
    module Purchase
      class NullOrderStrategy < SalesModeling::Domain::Purchase::OrderStrategy
        def execute(order)
          raise 'Unexpected order type_category'
        end
      end
    end
  end
end
