module DesignPattern
  module Command
    module Sample
      class DeleteEmployee
        def initialize(number)
          @number = number
        end

        def execute(system)
          system.delete_employee(@number)
        end
      end
    end
  end
end