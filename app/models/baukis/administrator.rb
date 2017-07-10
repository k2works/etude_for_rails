# == Schema Information
#
# Table name: baukis_administrators # 管理者
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null                 # メールアドレス
#  email_for_index :string(255)      not null                 # 索引用メールアドレス
#  hashed_password :string(255)                               # パスワード
#  suspended       :boolean          default(FALSE), not null # 停止フラグ
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  baukis_administrators_email  (email_for_index) UNIQUE
#

class Baukis::Administrator < ApplicationRecord
  include Baukis::EmailHolder
  include Baukis::PasswordHolder

  def active?
    !suspended?
  end
end
