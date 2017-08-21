module DesignPattern
  module Proxy
    class AccountProtectionProxy
      def initialize(real_account, owner_name)
        @subject = real_account
        @owner_name = owner_name
      end

      def method_missing(name, *args)
        check_access
        @subject.send( name, *args )
      end

      def check_access
        if @owner_name != 'Tom'
          raise "Illegal access: #{@owner_name} cannnot access account."
        end
      end
    end
  end
end