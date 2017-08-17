# == Schema Information
#
# Table name: baukis_message_tag_links
#
#  id         :integer          not null, primary key
#  message_id :integer          not null
#  tag_id     :integer          not null
#

require 'rails_helper'

RSpec.describe Baukis::MessageTagLink, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
