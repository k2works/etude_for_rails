class SalesModeling::Type::RegularOrderType < SalesModeling::Type::OrderType
  SYMBOL = 'ORD_REG'

  def regular_order?
    true
  end
end