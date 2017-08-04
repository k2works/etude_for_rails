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
# Indexes
#
#  index_rails_tutorial_sample_users_on_email  (email) UNIQUE
#

class RailsTutorial::Sample::User < ApplicationRecord
  before_save { self.email=email.downcase }
  validates :name, presence:true,length:{ maximum:50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, length:{ maximum:225 },
            format: { with:VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive:false }
end
