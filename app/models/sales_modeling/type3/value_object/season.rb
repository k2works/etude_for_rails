class SalesModeling::Type3::ValueObject::Season
  include SalesModeling::Category
  CATEGORY_CLASS_CODE = '2'

  def category_class_code
    CATEGORY_CLASS_CODE.rjust(CODE_LENGTH,'0')
  end
end