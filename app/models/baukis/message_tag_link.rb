# == Schema Information
#
# Table name: baukis_message_tag_links # メッセージタグリンク
#
#  id         :integer          not null, primary key
#  message_id :integer          not null              # メッセージへの外部キー
#  tag_id     :integer          not null              # タグへの外部キー
#
# Indexes
#
#  baukis_message_tag_links_message_id_tag_id    (message_id,tag_id) UNIQUE
#  index_baukis_message_tag_links_on_message_id  (message_id)
#  index_baukis_message_tag_links_on_tag_id      (tag_id)
#

class Baukis::MessageTagLink < ApplicationRecord
  belongs_to :message, :class_name => 'Baukis::Message', optional: true
  belongs_to :tag, :class_name => 'Baukis::Tag', optional: true
end
