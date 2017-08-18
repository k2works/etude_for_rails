require 'observer'
module DesignPattern
    module Observer
        class Employee2
            include ::Observable

            attr_reader :name
            attr_accessor :title, :salary

            def initialize(name, title, salary)
                super()
                @name = name
                @title = title
                @salary = salary
            end

            def salary=(new_salary)
                @salary = new_salary
                changed
                notify_observers(self)
            end
        end
    end
end
