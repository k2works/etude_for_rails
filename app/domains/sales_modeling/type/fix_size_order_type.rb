class SalesModeling::Type::FixSizeOrderType < SalesModeling::Type::OrderType
  SYMBOL = 'ORD_FIX'

  def fix_size_order?
    true
  end
end