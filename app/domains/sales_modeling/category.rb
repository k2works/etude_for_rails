module SalesModeling
  module Category
    include SalesModeling::Code
    extend ActiveSupport::Concern
    CATEGORY_CLASS_CODE = '0'

    def category_class_code
    end

    def category_symbol
    end
  end
end
