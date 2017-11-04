# frozen_string_literal: true

module SalesModeling
  class SkusRepo
    include ::SalesModeling::Type3

    def find(product_id)
      Sku.find(product_id)
    end

    def all
      Sku.all
    end

    def new(params = {})
      Sku.new(params)
    end

    def update(product, params)
      product.skus.each do |sku|
        sku.update(params)
      end
    end

    def destroy(sku)
      sku.destroy
    end

    def delete_all
      Sku.delete_all
    end

    def save(product, skus)
      skus.each do |sku|
        sku.sku_code = ValueObject::SkuCode.new(product.code, select_count.to_s)
        product.skus << sku
      end
      product.save!
    end

    def select_count
      Sku.count
    end

    def select_first
      Sku.first
    end

    def select_second
      Sku.second
    end

    def select_third
      Sku.third
    end

    def select_by_size(size)
      Sku.where(size_category_id: size.id)
    end

    def select_by_color(color)
      Sku.where(color_category_id: color.id)
    end

    def select_by_size_and_color(size, color)
      Sku.where(size_category_id: size.id, color_category_id: color.id)
    end
  end
end
