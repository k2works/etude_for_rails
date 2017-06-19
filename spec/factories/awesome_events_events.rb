FactoryGirl.define do
  factory :awesome_events_event, class: 'AwesomeEvents::Event' do
    owner_id 1
    name "MyString"
    place "MyString"
    start_time "2017-06-19 17:14:50"
    end_time "2017-06-19 17:14:50"
    content "MyText"
  end
end
