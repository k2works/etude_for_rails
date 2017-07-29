FactoryGirl.define do
  factory :outbound_message, class: 'Baukis::CustomerMessage' do
    customer
    subject 'OutboundMessage'
    body 'XXXXXXXXXXX'
  end

  factory :inbound_message, class: 'Baukis::StaffMessage' do
    customer
    subject 'InboundMessage'
    body 'XXXXXXXXXXX'
  end
end
