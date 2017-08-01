# == Schema Information
#
# Table name: baukis_addresses
#
#  id                 :integer          not null, primary key
#  baukis_customer_id :integer          not null
#  type               :string           not null
#  postal_code        :string           not null
#  prefecture         :string           not null
#  city               :string           not null
#  address1           :string           not null
#  address2           :string           not null
#  company_name       :string           default(""), not null
#  division_name      :string           default(""), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Baukis::WorkAddress < Baukis::Address
  before_validation do
    self.company_name = normalize_as_name(company_name)
    self.division_name = normalize_as_name(division_name)
  end

  validates :company_name, presence: true
end

