# frozen_string_literal: true

module SalesModeling
  class SalesRepo
    def new_sales_estimate(params = {})
      SalesModeling::Sales::SalesEstimate.new(params)
    end

    def new_sales_order(params = {})
      SalesModeling::Sales::SalesOrder.new(params)
    end

    def new_sales_line(sales, product, quantity)
      sales_line = sales.sales_lines.build
      sales_line.quantity_amount = quantity
      sales_line.quantity_unit = 'SUIT'
      sales_line.unit_sales_price_amount = product.unit_sales_price_amount
      sales_line.unit_sales_price_currency = product.unit_sales_price_currency
      sales_line.sales_price_amount = product.unit_sales_price_amount * sales_line.quantity_amount
      sales_line.sales_price_currency = product.unit_sales_price_currency
      sales_line.sales_modeling_type3_sku = product
    end

    def save(sales, sales_estimate = nil)
      sales.amount = 0
      n = 1
      sales.sales_lines.each do |line|
        line.line_number = n
        sales.amount += line.sales_price_amount
        sales.currency = line.sales_price_currency
        n += 1
      end
      sales.save!
      sales.set_sales_estimate(sales_estimate) unless sales_estimate.nil?
    end

    def copy_sales_line(sales, other)
      sales.sales_lines = other.sales_lines.dup
    end

    def select_all
      SalesModeling::Sales::Sale.all
    end

    def select_all_estimate
      SalesModeling::Sales::SalesEstimate.all
    end

    def select_all_order
      SalesModeling::Sales::SalesOrder.all
    end

    def select_first_sales_estimate
      SalesModeling::Sales::SalesEstimate.first
    end

    def select_third_sales_estimate
      SalesModeling::Sales::SalesEstimate.third
    end

    def select_first_sales_order
      SalesModeling::Sales::SalesOrder.first
    end
  end
end
