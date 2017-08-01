# == Schema Information
#
# Table name: baukis_staff_members
#
#  id               :integer          not null, primary key
#  email            :string           not null
#  email_for_index  :string           not null
#  family_name      :string           not null
#  given_name       :string           not null
#  family_name_kana :string           not null
#  given_name_kana  :string           not null
#  hashed_password  :string
#  start_date       :date             not null
#  end_date         :date
#  suspended        :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Baukis::StaffMember < ApplicationRecord
  include Baukis::EmailHolder
  include Baukis::PersonalNameHolder
  include Baukis::PasswordHolder

  has_many :events, class_name: 'Baukis::StaffEvent', foreign_key: :baukis_staff_member_id, dependent: :destroy
  has_many :programs, :class_name => 'Baukis::Program', foreign_key: 'registrant_id', dependent: :restrict_with_exception

  validates :start_date, presence: true, date: {
      after_or_equal_to: Date.new(2000,1,1),
      before: -> (obj) { 1.year.from_now.to_date },
      allow_blank: true
  }

  validates :email_for_index, uniqueness: { allow_blank: true }

  validates :end_date, date: {
      after: :start_date,
      before: -> (obj) { 1.year.from_now.to_date },
      allow_blank: true
  }

  def active?
    !suspended? && start_date <= Date.today &&
        (end_date.nil? || end_date > Date.today)
  end

  def deletable?
    programs.empty?
  end
end
