# == Schema Information
#
# Table name: baukis_entries
#
#  id          :integer          not null, primary key
#  program_id  :integer          not null
#  customer_id :integer          not null
#  approved    :boolean          default(FALSE), not null
#  canceled    :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Baukis::Entry, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
