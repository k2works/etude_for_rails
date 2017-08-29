module DesignPattern
  module Command
    module Sample
      class AddEmployee
        def initialize(employee)
          @employee = employee
        end

        def execute(system)
          system.add_employee(@employee)
        end
      end
    end
  end
end