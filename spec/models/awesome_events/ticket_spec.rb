# == Schema Information
#
# Table name: awesome_events_tickets
#
#  id                      :integer          not null, primary key
#  awesome_events_user_id  :integer
#  awesome_events_event_id :integer
#  comment                 :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require 'rails_helper'

RSpec.describe AwesomeEvents::Ticket, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
