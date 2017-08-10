# == Schema Information
#
# Table name: rails_tutorial_sample_relationships # 関係
#
#  id          :integer          not null, primary key
#  follower_id :integer                                # フォロー
#  followed_id :integer                                # フォロワー
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_rails_tutorial_sample_relationships_on_follow_followed  (follower_id,followed_id) UNIQUE
#  index_rails_tutorial_sample_relationships_on_followed         (followed_id)
#  index_rails_tutorial_sample_relationships_on_follower         (follower_id)
#

class RailsTutorial::Sample::Relationship < ApplicationRecord
  belongs_to :follower, :class_name => 'RailsTutorial::Sample::User'
  belongs_to :followed, :class_name => 'RailsTutorial::Sample::User'
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
