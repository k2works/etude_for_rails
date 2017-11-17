class SalesModeling::Price::UnitOrderPrice
  include SalesModeling::Price

  def +(other)
    raise "Currency is different" unless currency == other.currency

    SalesModeling::Price::UnitOrderPrice.new(amount + other.amount, currency)
  end

  def -(other)
    raise "Currency is different" unless currency == other.currency
    raise "Other money is bigger than self" if amount < other.amount

    SalesModeling::Price::UnitOrderPrice.new(amount - other.amount, currency)
  end

  def *(unit)
    raise "Invalid unit amount" unless unit.instance_of?(SalesModeling::Quantity)
    SalesModeling::Price::UnitOrderPrice.new(amount * unit.amount, currency)
  end

  def reduce
    SalesModeling::Price::UnitOrderPrice.new(amount)
  end
end