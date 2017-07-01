# == Schema Information
#
# Table name: perfect_rails_user2s
#
#  id           :integer          not null, primary key
#  name         :string
#  prefecture   :string
#  city         :string
#  house_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class PerfectRails::User2 < ApplicationRecord
  composed_of :address,
              class_name: 'PerfectRails::Address',
              mapping: [      %w(prefecture prefecture),
                              %w(city city),
                              %w(house_number house_number)
              ]
end
