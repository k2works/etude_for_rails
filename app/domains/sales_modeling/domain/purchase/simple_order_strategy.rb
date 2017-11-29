# frozen_string_literal: true

module SalesModeling
  module Domain
    module Purchase
      class SimpleOrderStrategy < SalesModeling::Domain::Purchase::OrderStrategy
        def execute
          @order
        end
      end
    end
  end
end
