# == Schema Information
#
# Table name: perfect_rails_users
#
#  id           :integer          not null, primary key
#  name         :string
#  prefecture   :string
#  city         :string
#  house_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class PerfectRails::User < ApplicationRecord
  # 都道府県が同じかどうかを返す
  # @retrun [Boolean]
  def same_prefecture?(other)
    prefecture == other.prefecture
  end

  # 市町村が同じかどうかを返す
  # @return [Boolean]
  def same_city?(other)
    city == other.city
  end
end
