require 'rails_helper'

RSpec.describe PerfectRails::Address, type: :model do
  let(:user) { create(:perfect_rails_user, prefecture:'広島県', city:'広島市') }
  let(:hiroshima_user) { create(:perfect_rails_user, prefecture:'広島県') }
  let(:okayama_user) { create(:perfect_rails_user, prefecture:'岡山県') }

  describe '#same_prefecture?' do
    context '都道府県が同じ場合' do
      it 'trueを返す' do
        expect(user.address.same_prefecture?(hiroshima_user)).to be_truthy
      end
    end

    context '都道府県が違う場合' do
      it 'falseを返す' do
        expect(user.address.same_prefecture?(okayama_user)).to be_falsey
      end
    end
  end

  describe '#same_city?' do
    context '市町村が同じ場合' do
      it 'trueを返す' do
        hiroshima_user.city = '広島市'
        expect(user.address.same_city?(hiroshima_user)).to be_truthy
      end
    end

    context '市町村が違う場合' do
      it 'falseを返す' do
        hiroshima_user.city = '福山市'
        expect(user.address.same_city?(hiroshima_user)).to be_falsey
      end
    end
  end

  describe '#==' do
    context 'アドレス以外の場合' do
      it 'falseを返す' do
        expect(user.address==hiroshima_user).to be_falsey
      end
    end

    context '都道府県と市町村が同じ場合' do
      it 'trueを返す' do
        hiroshima_user.city = '広島市'
        expect(user.address==hiroshima_user.address).to be_truthy
      end
    end

    context '都道府県と市町村が違う場合' do
      it 'falseを返す' do
        okayama_user.city = '岡山市'
        expect(user.address==okayama_user.address).to be_falsey
      end
    end
  end
end
