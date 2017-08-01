# == Schema Information
#
# Table name: perfect_rails_accounts
#
#  id         :integer          not null, primary key
#  amount     :integer
#  currency   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PerfectRails::Account < ApplicationRecord
  composed_of :balance,
              class_name: 'PerfectRails::Money',
              mapping: [%w(amount amount), %w(currency currency)]
end
