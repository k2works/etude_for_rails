# frozen_string_literal: true

module SalesModeling
  class StocksRepo
    def new_stock(params = {})
      stock_params = params[:stock_params]
      stock_line_params = params[:stock_line_params]

      stock = SalesModeling::Purchase::Stock.new(stock_params)
      order = stock.sales_modeling_purchase_order
      stock.sales_modeling_purchase_supplier = order.sales_modeling_purchase_supplier
      stock_line_params.each do |line_params|
        stock_line = stock.lines.build(line_params)
        stock_line.unit_price = SalesModeling::Price::UnitSalesPrice.new(stock_line.sales_modeling_type3_sku.unit_sales_price_amount)
        stock_line.calculate
      end
      stock
    end

    def save(params = {})
      stock = new_stock(params)
      stock.save!
    end

    def select_all
      SalesModeling::Purchase::Stock.all
    end

    def select_first
      SalesModeling::Purchase::Stock.first
    end

    def select_second
      SalesModeling::Purchase::Stock.second
    end

    def select_third
      SalesModeling::Purchase::Stock.third
    end
  end
end
