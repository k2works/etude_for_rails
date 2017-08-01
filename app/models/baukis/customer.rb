# == Schema Information
#
# Table name: baukis_customers
#
#  id               :integer          not null, primary key
#  email            :string           not null
#  email_for_index  :string           not null
#  family_name      :string           not null
#  given_name       :string           not null
#  family_name_kana :string           not null
#  given_name_kana  :string           not null
#  gender           :string
#  birthday         :date
#  hashed_password  :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  birth_year       :integer
#  birth_month      :integer
#  birth_mday       :integer
#

class Baukis::Customer < ApplicationRecord
  include Baukis::EmailHolder
  include Baukis::PersonalNameHolder
  include Baukis::PasswordHolder

  has_many :addresses, :class_name => 'Baukis::Address', foreign_key: :baukis_customer_id, dependent: :destroy
  has_one :home_address, class_name:'Baukis::HomeAddress', foreign_key: :baukis_customer_id, autosave: true
  has_one :work_address, class_name:'Baukis::WorkAddress', foreign_key: :baukis_customer_id, autosave: true
  has_many :phones, :class_name => 'Baukis::Phone', foreign_key: :baukis_customer_id, dependent: :destroy
  has_many :personal_phones, -> { where(baukis_address_id: nil).order(:id) }, :class_name => 'Baukis::Phone', foreign_key: :baukis_customer_id,autosave: true
  has_many :entries, :class_name => 'Baukis::Entry', dependent: :destroy
  has_many :programs, :class_name => 'Baukis::Program', through: :entries
  has_many :messages, :class_name => 'Baukis::Message'
  has_many :outbound_messages, :class_name => 'Baukis::CustomerMessage', foreign_key: :customer_id
  has_many :inbound_messages, :class_name => 'Baukis::StaffMessage', foreign_key: :customer_id

  validates :gender, inclusion: { in: %w(male female), allow_blank: true }
  validates :birthday, date: {
      after: Date.new(1900, 1, 1),
      before: -> (obj) { Date.today },
      allow_blank: true
  }

  before_save do
    if birthday
      self.birth_year = birthday.year
      self.birth_month = birthday.month
      self.birth_mday = birthday.mday
    end
  end
end
