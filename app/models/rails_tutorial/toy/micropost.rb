# == Schema Information
#
# Table name: rails_tutorial_toy_microposts
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RailsTutorial::Toy::Micropost < ApplicationRecord
  belongs_to :user, :class_name => 'RailsTutorial::Toy::User'
  validates :content, length: { maximum: 140 }
end
