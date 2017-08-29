module DesignPattern
  module Coc
    class RussolsenDotComAuthorizer
      def russolsen_dot_com_authorized?(message)
        true
      end

      def authorized?(message)
        message.body.size < 2048
      end
    end
  end
end
