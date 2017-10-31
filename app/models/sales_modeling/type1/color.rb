# == Schema Information
#
# Table name: sales_modeling_type1_colors # カラー
#
#  id         :integer          not null, primary key
#  code       :string(255)                            # コード
#  name       :string(255)                            # 名前
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SalesModeling::Type1::Color < ApplicationRecord
  has_many :sales_modeling_type1_products, :class_name => 'SalesModeling::Type1::Product'
end
