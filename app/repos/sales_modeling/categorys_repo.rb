module SalesModeling
  class CategorysRepo
    include ::SalesModeling::Type3

    def self.select_by_category(category)
      category = SalesModeling::Type3::Category.where(
        code: category.code,
        name: category.name
      ).first_or_create
      category.save!
      category
    end
  end
end