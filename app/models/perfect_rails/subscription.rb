# == Schema Information
#
# Table name: perfect_rails_subscriptions
#
#  id           :integer          not null, primary key
#  signed_up_on :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class PerfectRails::Subscription < ApplicationRecord
  before_create :record_signup

  private
  def record_signup
    self.signed_up_on = Date.today
  end
end
