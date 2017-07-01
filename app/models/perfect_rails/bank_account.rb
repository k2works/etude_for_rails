# == Schema Information
#
# Table name: perfect_rails_bank_accounts
#
#  id                 :integer          not null, primary key
#  credit_card_number :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require_relative '../perfect_rails/encryption_wrapper'

class PerfectRails::BankAccount < ApplicationRecord
  before_save EncryptionWrapper.new("credit_card_number")
  after_save EncryptionWrapper.new("credit_card_number")
  after_initialize EncryptionWrapper.new("credit_card_number")
end
