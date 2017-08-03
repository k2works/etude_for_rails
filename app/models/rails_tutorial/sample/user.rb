# == Schema Information
#
# Table name: rails_tutorial_sample_users # ユーザ
#
#  id         :integer          not null, primary key
#  name       :string(255)                            # 名前
#  emial      :string(255)                            # メールアドレス
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RailsTutorial::Sample::User < ApplicationRecord
end
