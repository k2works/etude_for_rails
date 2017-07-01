# == Schema Information
#
# Table name: perfect_rails_credit_cards
#
#  id         :integer          not null, primary key
#  number     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PerfectRails::CreditCard < ApplicationRecord
  before_validation(on: :create) do
    self.number = number.gsub(/[^0-9]/, "") if attribute_present?("number")
  end
end
