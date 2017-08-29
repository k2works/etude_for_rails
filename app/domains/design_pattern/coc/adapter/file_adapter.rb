module DesignPattern
  module Coc
    class FileAdapter
      def send_message(message)
        #
        # URLからパスを取得し
        # 先頭の'/'を取り除く
        #
        to_path = message.to.path
        to_path.slice!(0)

        File.open(to_path, 'w') do |f|
          f.write(message.body)
        end
      end
    end

    class FileAdapterStub
      def send_message(message)
        puts message.body
      end
    end
  end
end
