# == Schema Information
#
# Table name: sales_modeling_purchase_order_lines # 発注明細
#
#  id                                :integer          not null, primary key
#  line_number                       :integer                                # 明細番号
#  quantity_amount                   :decimal(10, )                          # 数量
#  quantity_unit                     :string(255)                            # 単位
#  unit_price_amount                 :decimal(10, )                          # 発注単価
#  unit_price_currency               :string(255)                            # 通貨
#  price_amount                      :decimal(10, )                          # 発注金額
#  price_currency                    :string(255)                            # 通貨
#  sales_modeling_purchase_orders_id :integer                                # 発注
#  sales_modeling_type3_sku_id       :integer                                # ストックキーピングユニット
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#
# Indexes
#
#  index_sales_modeling_purchase_order_line_id         (sales_modeling_purchase_orders_id)
#  index_sales_modeling_purchase_order_line_on_sku_id  (sales_modeling_type3_sku_id)
#
# Foreign Keys
#
#  fk_rails_9ccaabb37e  (sales_modeling_type3_sku_id => sales_modeling_type3_skus.id)
#  fk_rails_fb25b039a8  (sales_modeling_purchase_orders_id => sales_modeling_purchase_orders.id)
#

class SalesModeling::Purchase::OrderLine < ApplicationRecord
  belongs_to :sales_modeling_purchase_order, :class_name => 'SalesModeling::Purchase::Order', optional: true
  belongs_to :sales_modeling_type3_sku, class_name: 'SalesModeling::Type3::Sku', optional: true

  before_save do
    self.order_price = calculate_order_price
  end

  def unit_order_price
    @unit_order_price ||= SalesModeling::Price::UnitOrderPrice.new(unit_price_amount)
  end

  def unit_order_price=(price)
    self.unit_price_amount = price.amount
    self.unit_price_currency = price.currency
  end

  def order_price
    @order_price ||= calculate_order_price
  end

  def order_price=(price)
    self.price_amount = price.amount
    self.price_currency = price.currency
  end

  def quantity
    @quantity ||= SalesModeling::Quantity.new(quantity_amount, quantity_unit)
  end

  def quantity=(quantity)
    self.quantity_amount = quantity.amount
    self.quantity_unit = quantity.unit
  end

  private

  def calculate_order_price
    unit_order_price.*(quantity)
  end
end
