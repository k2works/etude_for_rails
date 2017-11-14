# frozen_string_literal: true

module SalesModeling
  module Money
    attr_reader :amount, :currency

    def initialize(amount, currency = 'JPY')
      @amount = amount
      @currency = currency
    end

    def ==(other)
      amount == other.amount && currency == other.currency
    end

    def +(other)
    end

    def -(other)
    end

    def reduce
    end
  end
end
