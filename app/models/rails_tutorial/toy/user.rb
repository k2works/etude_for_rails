# == Schema Information
#
# Table name: rails_tutorial_toy_users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RailsTutorial::Toy::User < ApplicationRecord
  has_many :microposts, :class_name => 'RailsTutorial::Toy::Micropost'
  validates :name, presence: true
  validates :email, presence: true
end
