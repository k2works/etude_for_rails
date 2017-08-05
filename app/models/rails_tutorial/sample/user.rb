# == Schema Information
#
# Table name: rails_tutorial_sample_users # ユーザ
#
#  id              :integer          not null, primary key
#  name            :string(255)                            # 名前
#  email           :string(255)                            # メールアドレス
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_digest :string(255)
#
# Indexes
#
#  index_rails_tutorial_sample_users_on_email  (email) UNIQUE
#

class RailsTutorial::Sample::User < ApplicationRecord
  attr_accessor :remember_token
  before_save { email.downcase! }
  validates :name, presence:true,length:{ maximum:50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, length:{ maximum:225 },
            format: { with:VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive:false }
  has_secure_password
  validates :password, presence:true,length: { minimum: 6 }, allow_nil:true

  class << self
    # 渡された文字列のハッシュ値を返す
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # ランダムなトークンを返す
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = RailsTutorial::Sample::User.new_token
    update_attribute(:remember_digest, RailsTutorial::Sample::User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
end
