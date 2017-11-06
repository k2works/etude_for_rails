# frozen_string_literal: true

module SalesModeling
  module Product
    module ApparelProduct
      attr_reader   :product_code,
                    :name,
                    :year,
                    :season,
                    :product_type,
                    :brand,
                    :skus

      def product_code=(code)
        @product_code = SalesModeling::Code::ProductCode.new(code)
      end

      def name=(name)
        @name = name
      end

      def year=(params)
        @year = SalesModeling::Category::Year.new(params[:code], params[:name])
      end

      def season=(params)
        @season = SalesModeling::Category::Season.new(params[:code], params[:name])
      end

      def product_type=(params)
        @season = SalesModeling::Type::ProductType.new(params[:code], params[:name])
      end

      def brand=(params)
        @brand = SalesModeling::Category::Brand.new(params[:code], params[:name])
      end

      def skus=(sku)
        @skus ||= []
        @skus << sku
      end
    end
  end
end
