module DesignPattern
  module Command
    module Sample
      class FindEmployee
        def initialize(number)
          @number = number
        end

        def execute(system)
          system.find_employee(@number)
        end
      end
    end
  end
end
