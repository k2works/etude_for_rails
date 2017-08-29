module DesignPattern
  module Coc
    class MessageGateway
      def initialize
        load_adapters
        load_authorizer
        @suffix = 'Adapter'
      end

      def process_message(message)
        adapter = adapter_for(message)
        adapter.send_message(message)
      end

      def adapter_for(message)
        protocol = message.to.scheme
        adapter_class = protocol.capitalize + @suffix
        name_space = self.class.to_s.split('::')
        adapter_class = Object.const_get("#{name_space[0]}::#{name_space[1]}::#{adapter_class}")
        adapter_class.new
      end

      def load_adapters
        lib_dir = File.dirname(__FILE__)
        full_pattern = File.join(lib_dir, 'adapter', '*.rb')
        Dir.glob(full_pattern).each {|file| require file}
      end

      def load_authorizer
        lib_dir = File.dirname(__FILE__)
        full_pattern = File.join(lib_dir, 'auth', '*.rb')
        Dir.glob(full_pattern).each {|file| require file}
      end

      def camel_case(string)
        tokens = string.split('.')
        tokens.map! {|t| t.capitalize}
        tokens.join('Dot')
      end

      def authorizer_for(message)
        to_host = message.to.host || 'default'
        authorizer_class = camel_case(to_host) + "Authorizer"
        name_space = self.class.to_s.split('::')
        authorizer_class = Object.const_get("#{name_space[0]}::#{name_space[1]}::#{authorizer_class}")
        authorizer_class.new
      end

      def worm_case(string)
        tokens = string.split('.')
        tokens.map! {|t| t.downcase}
        tokens.join('_dot_')
      end

      def authorized?(message)
        authorizer = authorizer_for(message)
        user_method = worm_case(message.from.host) + '_authorized?'
        if authorizer.respond_to?(user_method)
          return authorizer.send(user_method, message)
        end
        authorizer.authorized?(message)
      end
    end

    class MessageGatewayStub < MessageGateway
      def initialize
        super
        @suffix = 'AdapterStub'
      end
    end
  end
end
