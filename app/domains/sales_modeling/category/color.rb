class SalesModeling::Category::Color
  include SalesModeling::Category
  CATEGORY_CLASS_CODE = '5'

  def category_class_code
    CATEGORY_CLASS_CODE.rjust(CODE_LENGTH,'0')
  end
end