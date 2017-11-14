require 'tel_formatter'

module SalesModeling
  class Telephone
    attr_accessor :number

    def initialize(number)
      @number = format_phone(number)
    end

    def hash
      number.hash
    end

    def ==(other)
      return false unless other.is_a?(SalesModeling::Telephone)
      same_number?(other)
    end

    def same_number?(other)
      number == other.number
    end

    def format_phone(str)
      return str if str.blank?

      case str.size
        when 10..11
          TelFormatter.format(str)
        else
          str
      end
    end
  end
end