module DesignPattern
    module Observer
        class Employee3
            include Subject3
            attr_reader :name
            attr_accessor :title, :salary

            def initialize(name, title, salary)
                super()
                @name = name
                @title = title
                @salary = salary
                @observers = []
            end

            def salary=(new_salary)
                @salary = new_salary
                notify_observers
            end
        end
    end
end
