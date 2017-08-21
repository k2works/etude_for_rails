module DesignPattern
  module Proxy
    class AccountProtectionProxy
      def initialize(real_account, owner_name)
        @subject = real_account
        @owner_name = owner_name
      end

      def deposit(amount)
        check_access
        return @subject.deposit(amount)
      end

      def withdraw(amount)
        check_access
        return @subject.withdraw(amount)
      end

      def balance
        check_access
        return @subject.balance
      end

      def check_access
        if @owner_name != 'Tom'
          raise "Illegal access: #{@owner_name} cannnot access account."
        end
      end
    end
  end
end