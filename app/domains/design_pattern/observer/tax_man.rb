module DesignPattern
    module Observer
        class TaxMan
            def update( changed_employee )
                puts("#{changed_employee.name}に新しい税金の請求書を送ります！")
            end
        end
    end
end