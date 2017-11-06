module SalesModeling
  module Product
    module ApparelProductSku
      attr_reader :sku_code,
                  :unit_purchase_price,
                  :unit_sales_price

      def sku_code=(params)
        @sku_code = SalesModeling::Code::SkuCode.new(params[:product_code],params[:code])
      end

      def unit_purchase_price=(amount)
        @unit_purchase_price = SalesModeling::Price::UnitPurchasePrice.new(amount)
      end

      def unit_sales_price=(amount)
        @unit_sales_price = SalesModeling::Price::UnitSalesPrice.new(amount)
      end
    end
  end
end
