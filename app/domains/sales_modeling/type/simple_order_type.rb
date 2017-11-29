class SalesModeling::Type::SimpleOrderType < SalesModeling::Type::OrderType
  SYMBOL = 'ORD_SIM'

  def simple_order?
    true
  end
end