# == Schema Information
#
# Table name: sales_modeling_colors # カラー
#
#  id         :integer          not null, primary key
#  code       :string(255)                            # コード
#  name       :string(255)                            # 名前
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SalesModeling::Color < ApplicationRecord
  has_many :sales_modeling_products, :class_name => 'SalesModeling::Product'
end
