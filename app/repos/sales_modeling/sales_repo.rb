# frozen_string_literal: true

module SalesModeling
  include ::SalesModeling::Domain::Sales::SalesOrder
  include ::SalesModeling::Domain::Sales::SalesEstimate
  include ::SalesModeling::Domain::Sales::SalesLine

  class SalesRepo
    def new_sales_estimate(params = {})
      SalesModeling::Sales::SalesEstimate.new(params)
    end

    def new_sales_order(params = {})
      SalesModeling::Sales::SalesOrder.new(params)
    end

    def new_sales_line(sales, product, quantity)
      sales_line = sales.sales_lines.build
      sales_line.quantity = quantity
      sales_line.unit_sales_price = SalesModeling::Price::UnitSalesPrice.new(product.unit_sales_price_amount)
      sales_line.sales_modeling_type3_sku = product
    end

    def save(sales, sales_estimate = nil)
      sales.sales_price = SalesModeling::Price::SalesPrice.new(0)
      sum = SalesModeling::Price::SumPrice.new(sales.sales_price, sales.sales_price)
      n = 1
      sales.sales_lines.each do |sales_line|
        sales_line.line_number = n
        sum = sum.plus(sales_line.sales_price)
        sales.sales_price = sum.reduce
        n += 1
      end
      sales.save!
      sales.set_sales_estimate(sales_estimate) unless sales_estimate.nil?
    end

    def save_sales_line(sales, sales_line, params = {})
      sales_line.update(params)
      save(sales)
    end

    def copy_sales_line(sales, other)
      sales.sales_lines = other.sales_lines.dup
    end

    def select_all
      SalesModeling::Sales::Sale.all
    end

    def select_all_sales_line
      SalesModeling::Sales::SalesLine.all
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

    def destroy(sale)
      sale.destroy
    end

    def destroy_all
      SalesModeling::Sales::Sale.destroy_all
    end

    def destroy_all_estimate
      SalesModeling::Sales::SalesEstimate.destroy_all
    end

    def destroy_all_order
      SalesModeling::Sales::SalesOrder.destroy_all
    end
  end
end
