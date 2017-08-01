# == Schema Information
#
# Table name: baukis_message_tag_links
#
#  id         :integer          not null, primary key
#  message_id :integer          not null
#  tag_id     :integer          not null
#

FactoryGirl.define do
  factory :message_tag_link, class: 'Baukis::MessageTagLink' do
    message
    tag
  end
end
