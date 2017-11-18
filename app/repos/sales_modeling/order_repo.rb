# frozen_string_literal: true

module SalesModeling
  class OrderRepo
    def new_order(params = {})
      order_params = params[:order_params]
      order_line_params = params[:order_line_params]

      order = SalesModeling::Purchase::Order.new(order_params)
      order_line_params.each do |order_line_params|
        order_line = order.order_lines.build(order_line_params)
        order_line.unit_order_price = SalesModeling::Price::UnitSalesPrice.new(order_line.sales_modeling_type3_sku.unit_sales_price_amount)
        order.order_price = SalesModeling::Price::SalesPrice.new(0)
        sum = SalesModeling::Price::SumPrice.new(order.order_price, order.order_price)
        n = 1
        order.order_lines.each do |line|
          line.line_number = n
          sum = sum.plus(line.order_price)
          order.order_price = sum.reduce
          n += 1
        end
      end
      order
    end

    def save(params = {})
      order = new_order(params)
      order.save!
    end

    def select_first
      SalesModeling::Purchase::Order.first
    end
  end
end
