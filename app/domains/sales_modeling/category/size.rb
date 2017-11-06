class SalesModeling::Category::Size
  include SalesModeling::Category
  CATEGORY_CLASS_CODE = '6'

  def category_class_code
    CATEGORY_CLASS_CODE.rjust(CODE_LENGTH,'0')
  end
end