# == Schema Information
#
# Table name: perfect_rails_accounts # 口座
#
#  id         :integer          not null, primary key
#  amount     :integer                                # 金額
#  currency   :string(255)                            # 通貨
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PerfectRails::Account < ApplicationRecord
  composed_of :balance,
              class_name: 'PerfectRails::Money',
              mapping: [%w(amount amount), %w(currency currency)]
end
