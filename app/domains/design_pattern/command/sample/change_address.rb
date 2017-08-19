module DesignPattern
  module Command
    module Sample
      class ChangeAddress
        def initialize(number, address)
          @number = number
          @address = address
        end

        def execute(system)
          system.change_address(@number, @address)
        end
      end
    end
  end
end
