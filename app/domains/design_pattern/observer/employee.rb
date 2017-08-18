module DesignPattern
    module Observer
        class Employee
            attr_reader :name
            attr_accessor :title, :salary

            def initialize(name, title, salary)
                @name = name
                @title = title
                @salary = salary
                @observers = []
            end

            def salary=(new_salary)
                @salary = new_salary
                notify_observers
            end

            def notify_observers
              @observers.each do |observer|
                observer.update(self)
              end
            end

            def add_observer(observer)
              @observers << observer
            end

            def delete_observer(observer)
              @observers.delete(observer)
            end
        end
    end
end
