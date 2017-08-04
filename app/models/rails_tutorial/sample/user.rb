# == Schema Information
#
# Table name: rails_tutorial_sample_users # ユーザ
#
#  id         :integer          not null, primary key
#  name       :string(255)                            # 名前
#  email      :string(255)                            # メールアドレス
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RailsTutorial::Sample::User < ApplicationRecord
  validates :name, presence:true,length:{ maximum:50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, length:{ maximum:225 },format: { with:VALID_EMAIL_REGEX }
end
