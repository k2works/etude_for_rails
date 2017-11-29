class SalesModeling::Type::OrderType
  include SalesModeling::Type
  CATEGORY_CLASS_CODE = '3'
  SYMBOL = 'ORD'

  def category_class_code
    CATEGORY_CLASS_CODE.rjust(CODE_LENGTH,'0')
  end

  def category_symbol
    SYMBOL
  end

  def simple_order?
    false
  end

  def fix_size_order?
    false
  end

  def regular_order?
    false
  end
end