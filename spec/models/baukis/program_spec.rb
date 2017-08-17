# == Schema Information
#
# Table name: baukis_programs
#
#  id                         :integer          not null, primary key
#  registrant_id              :integer          not null
#  title                      :string           not null
#  description                :text
#  application_start_time     :datetime         not null
#  application_end_time       :datetime         not null
#  min_number_of_participants :integer
#  max_number_of_participants :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

require 'rails_helper'

RSpec.describe Baukis::Program, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
