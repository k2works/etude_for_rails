# == Schema Information
#
# Table name: perfect_rails_rooms
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :room, class: 'PerfectRails::Room' do
    
  end
end
