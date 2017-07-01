# == Schema Information
#
# Table name: perfect_rails_schedules
#
#  id          :integer          not null, primary key
#  room_id     :integer
#  finished_at :datetime
#  started_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :schedule, class: 'PerfectRails::Schedule' do
    room
  end
end
