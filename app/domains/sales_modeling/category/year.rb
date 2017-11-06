class SalesModeling::Category::Year
  include SalesModeling::Category
  CATEGORY_CLASS_CODE = '1'

  def category_class_code
    CATEGORY_CLASS_CODE.rjust(CODE_LENGTH,'0')
  end
end