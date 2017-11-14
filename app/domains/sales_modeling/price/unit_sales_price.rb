class SalesModeling::Price::UnitSalesPrice
  include SalesModeling::Price

  def +(other)
    raise "Currency is different" unless currency == other.currency

    SalesModeling::Price::UnitSalesPrice.new(amount + other.amount, currency)
  end

  def -(other)
    raise "Currency is different" unless currency == other.currency
    raise "Other money is bigger than self" if amount < other.amount

    SalesModeling::Price::UnitSalesPrice.new(amount - other.amount, currency)
  end

  def *(unit)
    raise "Invalid unit amount" unless unit.instance_of?(SalesModeling::Quantity)
    SalesModeling::Price::SalesPrice.new(amount * unit.amount, currency)
  end

  def reduce
    SalesModeling::Price::UnitSalesPrice.new(amount)
  end
end