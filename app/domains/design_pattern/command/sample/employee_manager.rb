module DesignPattern
  module Command
    module Sample
      class EmployeeManager
        def initialize
          @employees = {}
        end

        def add_employee(e)
          @employees[e.number] = e
        end

        def change_address(number, address)
          employee = @employees[number]
          raise 'No such employee' unless employee
          employee.address = address
        end

        def delete_employee(number)
          @employees.delete(number)
        end

        def find_employee(number)
          @employees[number]
        end
      end
    end
  end
end