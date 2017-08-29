module DesignPattern
  module CoC
    class FileAdapter
      #
      # URLからパスを取得し
      # 先頭の'/'を取り除く
      #
      to_path = message.to.path
      to_path.slice!(0)

      File.open(to_path, 'w') do |f|
        f.write(messagre.body)
      end
    end
  end
end
