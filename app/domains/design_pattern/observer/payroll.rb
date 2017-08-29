module DesignPattern
  module Observer
    class Payroll
      def update( changed_employee )
        puts("#{changed_employee.name}のために小切手を切ります！")
        puts("彼の給料はいま#{changed_employee.salary}です！")
      end
    end
  end
end