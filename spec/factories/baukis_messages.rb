# == Schema Information
#
# Table name: baukis_messages
#
#  id              :integer          not null, primary key
#  customer_id     :integer          not null
#  staff_member_id :integer
#  root_id         :integer
#  parent_id       :integer
#  type            :string           not null
#  status          :string           default("new"), not null
#  subject         :string           not null
#  body            :text
#  remarks         :text
#  discarded       :boolean          default(FALSE), not null
#  deleted         :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :customer_message, class: 'Baukis::CustomerMessage' do
    subject 'Subject'
    body "Body.\nBody."
    customer
  end

  factory :staff_message, class: 'Baukis::StaffMessage' do
    subject 'Subject'
    body "Body.\nBody."
    parent { FactoryGirl.create(:customer_message) }
    staff_member
  end

  factory :message, class: 'Baukis::CustomerMessage' do
    subject 'Subject'
    body "Body.\nBody."
    customer
  end
end
