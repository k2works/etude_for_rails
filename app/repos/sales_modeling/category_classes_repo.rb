# frozen_string_literal: true

module SalesModeling
  class CategoryClassesRepo
    include ::SalesModeling::Type3

    def self.select_by_category(category)
      category_class_code = category.category_class_code

      category = SalesModeling::Type3::Category.where(
        code: category.code,
        name: category.name
      ).first_or_create
      category.save!

      unless category_class_code.nil?
        category_class = SalesModeling::Type3::CategoryClass.where(
          code: category_class_code
        ).first_or_create
        category.update!(sales_modeling_type3_category_class: category_class)
      end

      category
    end
  end
end
