# == Schema Information
#
# Table name: baukis_hash_locks # 排他制御
#
#  id         :integer          not null, primary key
#  table      :string(255)      not null              # テーブル
#  column     :string(255)      not null              # カラム
#  key        :string(255)      not null              # キー
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Baukis::HashLock < ApplicationRecord
  class << self
    def acquire(table, column, value)
      Baukis::HashLock.where(table: table, column: column, key: Digest::MD5.hexdigest(value)[0,2]).lock(true).first!
    end
  end
end
