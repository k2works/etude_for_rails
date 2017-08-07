# == Schema Information
#
# Table name: rails_tutorial_sample_users # ユーザ
#
#  id                :integer          not null, primary key
#  name              :string(255)                            # 名前
#  email             :string(255)                            # メールアドレス
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  password_digest   :string(255)
#  remember_digest   :string(255)
#  admin             :boolean          default(FALSE)        # 管理者フラグ
#  activation_digest :string(255)                            # 認証ダイジェスト
#  activated         :boolean          default(FALSE)        # 認証フラグ
#  activated_at      :datetime                               # 認証日
#  reset_digest      :string(255)                            # リセットダイジェスト
#  reset_sent_at     :datetime                               # リセット送信日
#
# Indexes
#
#  index_rails_tutorial_sample_users_on_email  (email) UNIQUE
#

class RailsTutorial::Sample::User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_save   :downcase_email
  before_create :create_activation_digest
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

  # トークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  # アカウントを有効にする
  def activate
    update_columns(activated:true, activated_at:Time.zone.now )
  end

  # 有効化用のメールを送信する
  def send_activation_email
    RailsTutorial::Sample::UserMailer.account_activation(self).deliver_now
  end

  private

  # メールアドレスをすべて小文字にする
  def downcase_email
    self.email.downcase!
  end

  # 有効化トークンとダイジェストを作成および代入する
  def create_activation_digest
    self.activation_token  = RailsTutorial::Sample::User.new_token
    self.activation_digest = RailsTutorial::Sample::User.digest(activation_token)
  end
end
