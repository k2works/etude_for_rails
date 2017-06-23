FactoryGirl.define do
  factory :awesome_events_ticket, class: 'AwesomeEvents::Ticket' do
    user nil
    event nil
    comment "MyString"
  end
end
