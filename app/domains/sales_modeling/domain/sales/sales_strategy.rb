module SalesModeling
  module Domain
    module Sales
      class SalesStrategy
        def execute
          raise 'Abstract Class Called'
        end
      end
    end
  end
end
