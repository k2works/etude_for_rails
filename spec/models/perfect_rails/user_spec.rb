# == Schema Information
#
# Table name: perfect_rails_users
#
#  id           :integer          not null, primary key
#  name         :string
#  prefecture   :string
#  city         :string
#  house_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe PerfectRails::User, type: :model do
  let(:user) { create(:perfect_rails_user, prefecture:'広島県', city:'広島市') }
  let(:hiroshima_user) { create(:perfect_rails_user, prefecture:'広島県') }
  let(:okayama_user) { create(:perfect_rails_user, prefecture:'岡山県') }

  describe '#same_prefecture?' do
    context '都道府県が同じ場合' do
      it 'trueを返す' do
        expect(user.same_prefecture?(hiroshima_user)).to be_truthy
      end
    end

    context '都道府県が違う場合' do
      it 'falseを返す' do
        expect(user.same_prefecture?(okayama_user)).to be_falsey
      end
    end
  end

  describe '#same_city?' do
    context '市町村が同じ場合' do
      it 'trueを返す' do
        hiroshima_user.city = '広島市'
        expect(user.same_city?(hiroshima_user)).to be_truthy
      end
    end

    context '市町村が違う場合' do
      it 'falseを返す' do
        hiroshima_user.city = '福山市'
        expect(user.same_city?(hiroshima_user)).to be_falsey
      end
    end
  end
end
