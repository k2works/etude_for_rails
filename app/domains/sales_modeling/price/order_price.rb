class SalesModeling::Price::OrderPrice
  include SalesModeling::Price

  def +(other)
    raise "Currency is different" unless currency == other.currency

    SalesModeling::Price::OrderPrice.new(amount + other.amount, currency)
  end

  def -(other)
    raise "Currency is different" unless currency == other.currency
    raise "Other money is bigger than self" if amount < other.amount

    SalesModeling::Price::OrderPrice.new(amount - other.amount, currency)
  end

  def reduce
    SalesModeling::Price::OrderPrice.new(amount)
  end
end