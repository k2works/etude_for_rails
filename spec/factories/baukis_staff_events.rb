# == Schema Information
#
# Table name: baukis_staff_events
#
#  id                     :integer          not null, primary key
#  baukis_staff_member_id :integer          not null
#  event_type             :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

FactoryGirl.define do
  factory :staff_event, class: 'Baukis::StaffEvent' do
    staff_member
    event_type ''
    created_at "2017-07-06 13:18:34"
  end
end
