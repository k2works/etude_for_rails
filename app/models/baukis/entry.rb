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

class Baukis::Entry < ApplicationRecord
  belongs_to :program, :class_name => 'Baukis::Program'
  belongs_to :customer, :class_name => 'Baukis::Customer'
end
