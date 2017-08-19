module DesignPattern
  module Command
    module Sample
      class Employee
        attr_accessor :name, :number, :address

        def initialize(name, number, address)
          @name = name
          @number = number
          @address = address
        end

        def to_s
          "Employee: name: #{name} num: #{number} addr: #{address}"
        end
      end
    end
  end
end