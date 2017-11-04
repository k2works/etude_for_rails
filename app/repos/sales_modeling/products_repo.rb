module SalesModeling
  class ProductsRepo
    include ::SalesModeling::Type3

    def find(product_id)
      Product.find(product_id)
    end

    def all
      Product.all
    end

    def new(params = {})
      Product.new(params)
    end

    def update(product, params)
      product.update(params)
    end

    def destroy(product)
      product.destroy
    end

    def delete_all
      Product.delete_all
    end

    def delete_by_selected_code(code)
      select_by_code(code).delete_all
    end

    def save(product)
      product.save!
    end

    def select_first
      Product.first
    end

    def select_count
      Product.count
    end

    def select_by_code(code)
      Product.where(code: code)
    end

    def select_by_season(season)
      Product.where(season_category_id: season.id)
    end

    def select_by_brand(brand)
      Product.where(brand_category_id: brand.id)
    end
  end
end