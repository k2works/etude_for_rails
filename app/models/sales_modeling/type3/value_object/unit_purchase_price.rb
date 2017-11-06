class SalesModeling::Type3::ValueObject::UnitPurchasePrice
  include SalesModeling::Price

  def +(other)
    raise "Currency is different" unless currency == other.currency

    SalesModeling::Type3::ValueObject::UnitPurchasePrice.new(amount + other.amount, currency)
  end

  def -(other)
    raise "Currency is different" unless currency == other.currency
    raise "Other money is bigger than self" if amount < other.amount

    SalesModeling::Type3::ValueObject::UnitPurchasePrice.new(amount - other.amount, currency)
  end
end