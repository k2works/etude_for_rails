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
