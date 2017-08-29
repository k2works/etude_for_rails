protocol_name = ARGV[0]
class_name = protocol_name.capitalize + 'Adapter'
file_name = File.join('adapter', protocol_name + '.rb')

scaffolding = %Q{
module DesignPattern
  module Coc
    class #{class_name}

      def send_message(message)
        # メッセージを送信するコード
      end

    end
  end
end
}

if Rails.env.development?
  File.open(file_name, 'w') do |f|
    f.write(scaffolding)
  end
end
