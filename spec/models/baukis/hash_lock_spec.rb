# == Schema Information
#
# Table name: baukis_hash_locks
#
#  id         :integer          not null, primary key
#  table      :string           not null
#  column     :string           not null
#  key        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Baukis::HashLock, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
