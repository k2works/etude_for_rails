module SalesModeling
  class ProductsRepo
    include ::SalesModeling::Type3

    def find(product_id)
      Product.find(product_id)
    end

    def all
      Product.includes(:skus).references(:sales_modeling_type3_skus)
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

    def destroy_all
      Product.destroy_all
    end

    def destroy_by_size(size)
      select_by_size(size).destroy_all
    end

    def destroy_by_color(color)
      select_by_color(color).destroy_all
    end

    def destroy_by_size_and_color(color, size)
      select_by_size_and_color(color, size).destroy_all
    end

    def delete_all
      Product.delete_all
    end

    def delete_by_selected_code(code)
      select_by_code(code).delete_all
    end

    def save(product)
      product.product_code = SalesModeling::Type3::ValueObject::ProductCode.new((select_count + 1).to_s) if product.code.nil?
      product.save!
    end

    def select_count
      Product.count
    end

    def select_first
      Product.first
    end

    def select_second
      Product.second
    end

    def select_third
      Product.third
    end

    def select_by_code(code)
      Product.includes(:skus).references(:sales_modeling_type3_skus).where(code: code)
    end

    def select_by_season(season)
      Product.where(season_category_id: season.id)
    end

    def select_by_brand(brand)
      Product.where(brand_category_id: brand.id)
    end

    def select_by_size(size)
      Product.includes(:skus).references(:sales_modeling_type3_skus).where('sales_modeling_type3_skus.size_category_id = ?', size.id)
    end

    def select_by_color(color)
      Product.includes(:skus).references(:sales_modeling_type3_skus).where('sales_modeling_type3_skus.color_category_id = ?', color.id)
    end

    def select_by_size_and_color(size, color)
      Product.includes(:skus).references(:sales_modeling_type3_skus).where('sales_modeling_type3_skus.size_category_id = ? and sales_modeling_type3_skus.color_category_id = ?', size.id, color.id)
    end
  end
end