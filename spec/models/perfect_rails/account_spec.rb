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

require 'rails_helper'

RSpec.describe PerfectRails::Account, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
