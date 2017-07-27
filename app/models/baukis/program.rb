# == Schema Information
#
# Table name: baukis_programs # プログラム
#
#  id                         :integer          not null, primary key
#  registrant_id              :integer          not null              # 登録職員（外部キー）
#  title                      :string(255)      not null              # タイトル
#  description                :text(65535)                            # 説明
#  application_start_time     :datetime         not null              # 申し込み開始日時
#  application_end_time       :datetime         not null              # 申し込み終了日時
#  min_number_of_participants :integer                                # 最小参加者数
#  max_number_of_participants :integer                                # 最大参加者数
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  baukis_programs_application_start_time  (application_start_time)
#  baukis_programs_registrant_id           (registrant_id)
#  index_baukis_programs_on_registrant_id  (registrant_id)
#

class Baukis::Program < ApplicationRecord
end
