# == Schema Information
#
# Table name: baukis_phones
#
#  id                 :integer          not null, primary key
#  baukis_customer_id :integer          not null
#  baukis_address_id  :integer
#  number             :string           not null
#  number_for_index   :string           not null
#  primary            :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  last_four_digits   :string
#

class Baukis::Phone < ApplicationRecord
  include Baukis::StringNormalizer

  belongs_to :customer, :class_name => 'Baukis::Customer', foreign_key: :baukis_customer_id, optional: true
  belongs_to :address, :class_name => 'Baukis::Address', foreign_key: :baukis_address_id, optional: true

  before_validation do
    self.number = normalize_as_phone_number(number)
    self.number_for_index = number.gsub(/\D/,'') if number
  end

  before_create do
    self.customer = address.customer if address
    if number_for_index && number_for_index.size >= 4
      self.last_four_digits = number_for_index[-4, 4]
    end
  end

  validates :number, presence: true, format: { with: /\A\+?\d+(-\d+)*\z/, allow_blank: true }
end
