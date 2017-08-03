# == Schema Information
#
# Table name: baukis_entries # 申し込み
#
#  id          :integer          not null, primary key
#  program_id  :integer          not null
#  customer_id :integer          not null
#  approved    :boolean          default(FALSE), not null # 承認済みフラグ
#  canceled    :boolean          default(FALSE), not null # 取り消しフラグ
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  baukis_entries_customer_id             (customer_id)
#  baukis_entries_program_id_customer_id  (program_id,customer_id) UNIQUE
#  index_baukis_entries_on_customer_id    (customer_id)
#  index_baukis_entries_on_program_id     (program_id)
#

class Baukis::Entry < ApplicationRecord
  belongs_to :program, :class_name => 'Baukis::Program'
  belongs_to :customer, :class_name => 'Baukis::Customer'
end
