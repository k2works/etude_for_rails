# frozen_string_literal: true

class SalesModeling::Price::SumPrice
  include SalesModeling::Price

  def initialize(augend, addend)
    @augend = augend
    @addend = addend
  end

  def plus(added)
    SalesModeling::Price::SumPrice.new(self, added)
  end

  def reduce
    amount = @augend.reduce.amount + @addend.reduce.amount
    SalesModeling::Price::SalesPrice.new(amount)
  end
end
