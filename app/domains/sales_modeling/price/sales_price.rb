class SalesModeling::Price::SalesPrice
  include SalesModeling::Price

  def +(other)
    raise "Currency is different" unless currency == other.currency

    SalesModeling::Price::SalesPrice.new(amount + other.amount, currency)
  end

  def -(other)
    raise "Currency is different" unless currency == other.currency
    raise "Other money is bigger than self" if amount < other.amount

    SalesModeling::Price::SalesPrice.new(amount - other.amount, currency)
  end

  def reduce
    SalesModeling::Price::SalesPrice.new(amount)
  end
end