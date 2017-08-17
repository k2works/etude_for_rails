# == Schema Information
#
# Table name: baukis_tags
#
#  id    :integer          not null, primary key
#  value :string           not null
#

FactoryGirl.define do
  factory :tag, class: 'Baukis::Tag' do
    sequence(:value) { |n| "tag_#{n}" }
  end
end
