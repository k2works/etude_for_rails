class SalesModeling::Category::Brand
  include SalesModeling::Category
  CATEGORY_CLASS_CODE = '4'

  def category_class_code
    CATEGORY_CLASS_CODE.rjust(CODE_LENGTH,'0')
  end
end