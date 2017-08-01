# == Schema Information
#
# Table name: baukis_tags
#
#  id    :integer          not null, primary key
#  value :string           not null
#

class Baukis::Tag < ApplicationRecord
  has_many :message_tag_links, :class_name => 'Baukis::MessageTagLink', dependent: :destroy
  has_many :messages, through: :message_tag_links
end
