FactoryGirl.define do
  factory :outbound_message, class: 'Baukis::CustomerMessage' do
    customer
    subject 'OutboundMessage'
  end

  factory :inbound_message, class: 'Baukis::StaffMessage' do
    customer
    subject 'InboundMessage'
  end
end
