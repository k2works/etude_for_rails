# == Schema Information
#
# Table name: rails_tutorial_sample_microposts # マイクロポスト
#
#  id                            :integer          not null, primary key
#  content                       :text(65535)                            # 内容
#  rails_tutorial_sample_user_id :integer
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#
# Indexes
#
#  index_rails_tutorial_sample_micropost_on_user_id             (rails_tutorial_sample_user_id)
#  index_rails_tutorial_sample_micropost_on_user_id_created_at  (rails_tutorial_sample_user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_781cebf7bb  (rails_tutorial_sample_user_id => rails_tutorial_sample_users.id)
#

class RailsTutorial::Sample::Micropost < ApplicationRecord
  belongs_to :user, :class_name => 'RailsTutorial::Sample::User',foreign_key: :rails_tutorial_sample_user_id
  validates :rails_tutorial_sample_user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
