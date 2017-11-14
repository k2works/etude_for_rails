# frozen_string_literal: true

module SalesModeling
  class Quantity
    attr_reader :amount, :unit

    def initialize(amount, unit)
      @amount = amount
      @unit = unit
    end

    def ==(other)
      amount == other.amount && unit == other.unit
    end

    def +(other)
      raise "Unit is different" unless unit == other.unit

      SalesModeling::Quantity.new(amount + other.amount, unit)
    end

    def -(other)
      raise "Unit is different" unless unit == other.unit
      raise "Other quantity is bigger than self" if amount < other.amount

      SalesModeling::Quantity.new(amount - other.amount, unit)
    end
  end
end
