# == Schema Information
#
# Table name: rails_tutorial_toy_users # ユーザー
#
#  id         :integer          not null, primary key
#  name       :string(255)                            # 名前
#  email      :string(255)                            # メールアドレス
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RailsTutorial::Toy::User < ApplicationRecord
  has_many :microposts, :class_name => 'RailsTutorial::Toy::Micropost'
  validates :name, presence: true
  validates :email, presence: true
end
