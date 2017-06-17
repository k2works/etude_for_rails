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
end
