# == Schema Information
#
# Table name: awesome_events_users # ログインユーザ
#
#  id         :integer          not null, primary key
#  provider   :string(255)                            # プロバイダ名
#  uid        :string(255)                            # ブロバイダ別ユーザ識別子
#  nickname   :string(255)                            # TwitterID
#  image_url  :string(255)                            # Twitterアイコン画像URL
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AwesomeEvents::User < ApplicationRecord
  def self.find_or_create_from_auth_hash(auth_hash)
    has_many :created_events, class_name: 'AwesomeEvents::Event', foreign_key: :owner_id

    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    nickname = auth_hash[:info][:nickname]
    image_url = auth_hash[:info][:image]

    AwesomeEvents::User.find_or_create_by(provider: provider, uid: uid) do |user|
      user.nickname = nickname
      user.image_url = image_url
    end
  end
end
