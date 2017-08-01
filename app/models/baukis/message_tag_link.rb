# == Schema Information
#
# Table name: baukis_message_tag_links
#
#  id         :integer          not null, primary key
#  message_id :integer          not null
#  tag_id     :integer          not null
#

class Baukis::MessageTagLink < ApplicationRecord
  belongs_to :message, :class_name => 'Baukis::Message', optional: true
  belongs_to :tag, :class_name => 'Baukis::Tag', optional: true
end
