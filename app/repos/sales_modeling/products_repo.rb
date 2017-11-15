# frozen_string_literal: true

module SalesModeling
  class ProductsRepo
    include ::SalesModeling::Product::ApparelProduct
    include ::SalesModeling::Product::ApparelProductSku

    def find(product_id)
      ::SalesModeling::Type3::Product.find(product_id)
    end

    def all
      ::SalesModeling::Type3::Product.includes(:skus).references(:sales_modeling_type3_skus)
    end

    def all_sku
      ::SalesModeling::Type3::Sku.all
    end

    def new(params = {})
      self.product_code = (select_count + 1).to_s
      self.name = params[:name]
      self.year = params[:season].parent_category
      self.season = params[:season]
      self.product_type = params[:type]
      self.brand = params[:brand]
      params[:product_code] = @product_code
      ::SalesModeling::Type3::Product.new(params)
    end

    def new_sku(product, params = {})
      self.sku_code = ({ product_code: product.code, code: select_count.to_s })
      self.unit_purchase_price = params[:unit_purchase_price]
      self.unit_sales_price = params[:unit_sales_price]
      params[:sku_code] = @sku_code
      product.skus.build(params)
    end

    def update(product, params)
      product.update(params)
    end

    def update_sku(product, params)
      product.skus.each do |sku|
        sku.update(params)
      end
    end

    def destroy(product)
      product.destroy
    end

    def destroy_all
      ::SalesModeling::Type3::Product.destroy_all
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
      ::SalesModeling::Type3::Product.delete_all
    end

    def delete_by_selected_code(code)
      select_by_code(code).delete_all
    end

    def save(product)
      if product.code.nil?
        self.product_code = (select_count + 1).to_s
        product.product_code = @product_code
      end

      product.skus.each do |sku|
        if sku.code.nil?
          self.sku_code = ({ product_code: product.code, code: select_count.to_s })
          sku.sku_code = @sku_code
        end
      end

      product.save!
    end

    def select_count
      ::SalesModeling::Type3::Product.count
    end

    def select_all_sku_count
      ::SalesModeling::Type3::Sku.count
    end

    def select_first
      ::SalesModeling::Type3::Product.first
    end

    def select_second
      ::SalesModeling::Type3::Product.second
    end

    def select_third
      ::SalesModeling::Type3::Product.third
    end

    def select_all_sku_first
      ::SalesModeling::Type3::Sku.first
    end

    def select_all_sku_second
      ::SalesModeling::Type3::Sku.second
    end

    def select_all_sku_third
      ::SalesModeling::Type3::Sku.third
    end

    def select_by_code(code)
      ::SalesModeling::Type3::Product.includes(:skus).references(:sales_modeling_type3_skus).where(code: code)
    end

    def select_by_sku_code(code)
      product = ::SalesModeling::Type3::Product.includes(:skus).references(:sales_modeling_type3_skus).where('sales_modeling_type3_skus.code = ?', code)
      product.first.skus.first
    end

    def select_by_season(season)
      ::SalesModeling::Type3::Product.where(season_category_id: season.id)
    end

    def select_by_brand(brand)
      ::SalesModeling::Type3::Product.where(brand_category_id: brand.id)
    end

    def select_by_size(size)
      ::SalesModeling::Type3::Product.includes(:skus).references(:sales_modeling_type3_skus).where('sales_modeling_type3_skus.size_category_id = ?', size.id)
    end

    def select_by_color(color)
      ::SalesModeling::Type3::Product.includes(:skus).references(:sales_modeling_type3_skus).where('sales_modeling_type3_skus.color_category_id = ?', color.id)
    end

    def select_by_size_and_color(size, color)
      ::SalesModeling::Type3::Product.includes(:skus).references(:sales_modeling_type3_skus).where('sales_modeling_type3_skus.size_category_id = ? and sales_modeling_type3_skus.color_category_id = ?', size.id, color.id)
    end

    def select_all_sku_by_size(size)
      ::SalesModeling::Type3::Sku.where(size_category_id: size.id)
    end

    def select_all_sku_by_color(color)
      ::SalesModeling::Type3::Sku.where(color_category_id: color.id)
    end

    def select_all_sku_by_size_and_color(size, color)
      ::SalesModeling::Type3::Sku.where(size_category_id: size.id, color_category_id: color.id)
    end
  end
end
