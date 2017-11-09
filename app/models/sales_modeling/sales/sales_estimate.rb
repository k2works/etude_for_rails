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

class SalesModeling::Sales::SalesEstimate < SalesModeling::Sales::Sale
  belongs_to :sales_type_category, class_name: 'SalesModeling::Type3::Category'
  has_many :sales_lines, :class_name => 'SalesModeling::Sales::SalesLine'
end
