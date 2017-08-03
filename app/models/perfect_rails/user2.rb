# == Schema Information
#
# Table name: perfect_rails_user2s # ユーザ２
#
#  id           :integer          not null, primary key
#  name         :string(255)                            # 名前
#  prefecture   :string(255)                            # 都道府県
#  city         :string(255)                            # 市町村
#  house_number :string(255)                            # 番地
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
