# == Schema Information
#
# Table name: todo_tasks
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  content    :text             not null
#  status     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :todo_task, class: 'Todo::Task' do
    name "MyString"
    content "MyText"
    status 1
  end
end
