# == Schema Information
#
# Table name: baukis_staff_events
#
#  id                     :integer          not null, primary key
#  baukis_staff_member_id :integer          not null
#  event_type             :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'rails_helper'

RSpec.describe Baukis::StaffEvent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
