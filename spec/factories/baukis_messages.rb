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
end
