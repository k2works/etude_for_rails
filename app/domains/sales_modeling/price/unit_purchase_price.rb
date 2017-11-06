class SalesModeling::Price::UnitPurchasePrice
  include SalesModeling::Price

  def +(other)
    raise "Currency is different" unless currency == other.currency

    SalesModeling::Price::UnitPurchasePrice.new(amount + other.amount, currency)
  end

  def -(other)
    raise "Currency is different" unless currency == other.currency
    raise "Other money is bigger than self" if amount < other.amount

    SalesModeling::Price::UnitPurchasePrice.new(amount - other.amount, currency)
  end
end