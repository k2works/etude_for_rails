module DesignPattern
  module Coc
    class MessageGateway
      def initialize
        load_adapters
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
        adapter_class = Object.const_get(name_space[0]+'::'+name_space[1]+'::'+adapter_class)
        adapter_class.new
      end

      def load_adapters
        lib_dir = File.dirname(__FILE__)
        full_pattern = File.join(lib_dir, 'adapter', '*.rb')
        Dir.glob(full_pattern).each {|file| require file}
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
