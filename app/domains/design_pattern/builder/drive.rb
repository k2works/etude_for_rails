module DesignPattern
  module Builder
    class Drive
      attr_reader :type # :hard_diskか:cdか:dvd
      attr_reader :size # MBで
      attr_reader :writable # ドライブが書き込み可能ならばtrue

      def initialize(type, size, writable)
        @type = type
        @size = size
        @writable = writable
      end
    end
  end
end