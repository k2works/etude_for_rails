# == Schema Information
#
# Table name: perfect_rails_schedules
#
#  id          :integer          not null, primary key
#  room_id     :integer
#  finished_at :datetime
#  started_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class PerfectRails::Schedule < ApplicationRecord
  belongs_to :room, class_name: 'PerfectRails::Room', foreign_key: :id, optional: true
  validates_with MustNotOverlapValidator
end
