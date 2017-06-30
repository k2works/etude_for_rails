# == Schema Information
#
# Table name: perfect_rails_subscriptions
#
#  id           :integer          not null, primary key
#  signed_up_on :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe PerfectRails::Subscription, type: :model do
  describe '#signed_up_on' do
    context '作成したとき' do
      it '今日の日付が入る' do
        subscription = create(:subscription)
        expect(subscription.signed_up_on).to eq Date.today
      end
    end
  end
end
