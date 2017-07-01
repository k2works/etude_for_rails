# == Schema Information
#
# Table name: perfect_rails_users # ユーザ
#
#  id           :integer          not null, primary key
#  name         :string(255)                            # 名前
#  prefecture   :string(255)                            # 都道府県
#  city         :string(255)                            # 市町村
#  house_number :string(255)                            # 番地
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class PerfectRails::User < ApplicationRecord
  def address
    @address ||= PerfectRails::Address.new(prefecture, city, house_number)
  end

  def address=(address)
    self.prefecture= address.prefecture
    self.city = address.city
    self.house_number = address.house_number
    @address = address
  end
end
