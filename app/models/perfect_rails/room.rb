# == Schema Information
#
# Table name: perfect_rails_rooms
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PerfectRails::Room < ApplicationRecord
  has_many :schedules, class_name:'PerfectRails::Schedule', foreign_key: :room_id
end
