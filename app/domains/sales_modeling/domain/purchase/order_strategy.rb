# frozen_string_literal: true

module SalesModeling
  module Domain
    module Purchase
      class OrderStrategy
        def initialize(order)
          @order = order
        end

        def execute
          raise 'Abstract Class Called'
        end
      end
    end
  end
end
