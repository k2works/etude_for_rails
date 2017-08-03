# == Schema Information
#
# Table name: rails_tutorial_toy_microposts # マイクロポスト
#
#  id         :integer          not null, primary key
#  content    :text(65535)                            # 内容
#  user_id    :integer                                # ユーザID
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RailsTutorial::Toy::Micropost < ApplicationRecord
  belongs_to :user, :class_name => 'RailsTutorial::Toy::User'
  validates :content, length: { maximum: 140 }, presence: true
end
