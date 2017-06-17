# == Schema Information
#
# Table name: awesome_events_users
#
#  id         :integer          not null, primary key
#  provider   :string
#  uid        :string
#  nickname   :string
#  image_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe AwesomeEvents::User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
