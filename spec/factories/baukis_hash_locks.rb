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

FactoryGirl.define do
  factory :baukis_hash_lock, class: 'Baukis::HashLock' do
    
  end
end
