class SalesModeling::Type::SalesEstimateType
  include SalesModeling::Type
  CATEGORY_CLASS_CODE = '3'
  SYMBOL = 'SEST'

  def category_class_code
    CATEGORY_CLASS_CODE.rjust(CODE_LENGTH,'0')
  end

  def category_symbol
    SYMBOL
  end
end