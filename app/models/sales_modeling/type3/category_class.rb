# == Schema Information
#
# Table name: sales_modeling_type3_category_classes # 分類種別
#
#  id         :integer          not null, primary key
#  code       :string(255)                            # コード
#  name       :string(255)                            # 分類種別名
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SalesModeling::Type3::CategoryClass < ApplicationRecord
  has_many :categories, :class_name => 'SalesModeling::Type3::Category', :foreign_key => 'sales_modeling_type3_category_class_id'
end
