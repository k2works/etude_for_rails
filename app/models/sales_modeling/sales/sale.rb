# == Schema Information
#
# Table name: sales_modeling_sales_sales # 売上
#
#  id                               :integer          not null, primary key
#  type                             :string(255)                            # STIカラム
#  date                             :datetime                               # 売上日
#  amount                           :decimal(10, )                          # 金額
#  currency                         :string(255)                            # 通貨
#  sales_modeling_sales_customer_id :integer                                # 顧客
#  sales_type_category_id           :integer                                # 売上区分
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#
# Indexes
#
#  index_sales_modeling_sales_on_customer_id     (sales_modeling_sales_customer_id)
#  index_sales_modeling_sales_sales_category_id  (sales_type_category_id)
#
# Foreign Keys
#
#  fk_rails_dfbf4d475e  (sales_modeling_sales_customer_id => sales_modeling_sales_customers.id)
#

class SalesModeling::Sales::Sale < ApplicationRecord
  belongs_to :sales_modeling_sales_customer, class_name: 'SalesModeling::Sales::Customer'
  belongs_to :sales_type_category

  def date_of_occurrence
    @date_of_occurrence ||= SalesModeling::Date::DateOfOccurrences(date)
  end

  def date_of_occurrence=(biz_date)
    self.date = biz_date.date
  end

  def sales_price
    @sales_price ||= SalesModeling::Price::SalesPrice.new(amount)
  end

  def sales_price=(price)
    self.amount = price.amount
    self.currency = price.currency
  end
end
