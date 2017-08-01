# == Schema Information
#
# Table name: baukis_hash_locks
#
#  id         :integer          not null, primary key
#  table      :string           not null
#  column     :string           not null
#  key        :string           not null
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
