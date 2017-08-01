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
