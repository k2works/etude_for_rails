module Payroll
  module TextParserTransactionSource
    class TextParserTransactionSource < TransactionApplicationSource::TransactionSource
      def execute
        parse
      end

      def set_source(source)
        @its_source = source
      end

      private
      def parse
        if @its_source.nil?
          raise StandardError, 'Not set Source File'
        else
          begin
            File.open(@its_source) do |file|
              file.each_line do |line|
                line_strs = line.split(" ")
                line_list = Array.new
                doublequote_flag = false
                sb = nil
                line_strs.each do |str|
                  if doublequote_flag
                    sb << " " + str
                    if str.end_with?("\"")
                      line_list << sb.to_s
                      doublequote_flag = false
                    end
                  else
                    if str.start_with?("\"") && str.end_with?("\"") == false
                      sb = String.new
                      doublequote_flag = true
                    else
                      line_list << str.gsub(/\"/,'')
                    end
                  end
                end
                line_execute(line_list)
              end
            end
          rescue SystemCallError => e
            puts %Q(class=[#{e.class}] message=[#{e.message}])
          rescue IOError => e
            puts %Q(class=[#{e.class}] message=[#{e.message}])
          rescue ParseException => e
            puts %Q(class=[#{e.class}] message=[#{e.message}])
          end
        end
      end

      def line_execute(line)
        begin
          if line.size < 1
            raise StandardError, 'Read Line Error'
          end
          t = nil
          transaction_name = line.fetch(0,nil)
          if transaction_name.eql?("AddEmp")
            t = add_emp(line)
          elsif transaction_name.eql?("ChgEmp")
            t = chg_emp(line)
          elsif transaction_name.eql?("DelEmp")
            emp_id = line.fetch(1).to_i
            t = new DeleteEmployeeTransaction(emp_id)
          elsif transaction_name.eql?("ServiceCharge")
            member_id = line.fetch(1).to_i
            date = line.fetch(2)
            date = Date.new(date.slice(0,4).to_i,date.slice(5,2).to_i,date.slice(8,2).to_i)
            amount = line.fetch(3).to_d
            t = ServiceChargeTransaction.new(member_id, date, amount)
          elsif transaction_name.eql?("SalesReceipt")
            emp_id = line.fetch(1).to_i
            date = line.fetch(2)
            date = Date.new(date.slice(0,4).to_i,date.slice(5,2).to_i,date.slice(8,2).to_i)
            amount = line.fetch(3).to_d
            t = SalesReceiptTransaction.new(date, amount, emp_id)
          elsif transaction_name.eql?("TimeCard")
            emp_id = line.fetch(1).to_i
            date = line.fetch(2)
            date = Date.new(date.slice(0,4).to_i,date.slice(5,2).to_i,date.slice(8,2).to_i)
            hours = line.fetch(3).to_d
            t = TimeCardTransaction.new(date,hours,emp_id)
          elsif transaction_name.eql?("Payday")
            pay_date = line.fetch(1)
            t = PaydayTransaction(pay_date)
          end

          unless t.nil?
            t.execute
          end
        rescue Exception => e
          raise ParseException.new
        end
      end

      def add_emp(line)
        t = nil
        emp_id = line.fetch(1).to_i
        if line.fetch(4).eql?("H")
          hourly_rate = line.fetch(5).to_d
          t = AddHourlyEmployee.new(emp_id, line.fetch(2), line.fetch(3), hourly_rate)
        elsif line.fetch(4).eql?("S")
          salary = line.fetch(5)
          t = AddSalariedEmployee.new(emp_id, line.fetch(2), line.fetch(3), salary)
        elsif line.fetch(4).eql?("C")
          salary = line.fetch(5)
          commision_rate = line.fetch(6)
          t = AddCommissionedEmployee(emp_id, line.fetch(2), line.fetch(3), salary, commision_rate)
        end
        t
      end

      def chg_emp(line)
        t = nil
        emp_id = line.fetch(1).to_i
        change_info = line.fetch(2)
        if change_info.eql?("Name")
          name = line.fetch(3)
          t = ChangeNameTransaction.new(emp_id, name)
        elsif change_info.eql?("Address")
          address = line.fetch(3)
          t = ChangeAddressTransaction(emp_id, address)
        elsif change_info.eql?("Hourly")
          hourly = line.fetch(3).to_d
          t = ChangeHourlyTransaction.new(emp_id, hourly)
        elsif change_info.eql?("Salaried")
          salary = line.fetch(3)
          t = ChangeSalariedTransaction.new(emp_id, salary)
        elsif change_info.eql?("Commissioned")
          salary = line.fetch(3).to_d
          rate = line.fetch(4).to_d
          t = ChangeCommissionedTransaction.new(emp_id,salary,rate)
        elsif change_info.eql?("Hold")
          t = ChangeHoldTransaction.new(emp_id)
        elsif change_info.eql?("Direct")
          bank = line.fetch(3)
          account = line.fetch(4)
          t = ChangeDirectTransaction.new(emp_id, bank, account)
        elsif change_info.eql?("Mail")
          address = line.fetch(3)
          t = ChangeMailTransaction.new(emp_id,address)
        elsif change_info.eql?("Member")
          member_id = line.fetch(3).to_i
          dues = line.fetch(5).to_d
          t = ChangeMemberTransaction.new(emp_id, member_id, dues)
        elsif change_info.eql?("NoMember")
          t = ChangeUnaffiliatedTransaction.new(emp_id)
        end
        t
      end
    end

    class ParseException < StandardError; end
  end
end