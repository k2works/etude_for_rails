class SalesModeling::Type::WarehouseType
  include SalesModeling::Type
  CATEGORY_CLASS_CODE = '3'
  SYMBOL = 'WAH'

  def category_class_code
    CATEGORY_CLASS_CODE.rjust(CODE_LENGTH,'0')
  end
end