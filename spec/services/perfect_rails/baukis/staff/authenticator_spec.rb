
require 'rails_helper'

describe Baukis::Staff::Authenticator do
  describe '#authenticate' do
    example '正しいパスワードならtrueを返す' do
      m = build(:staff_member)
      expect(Baukis::Staff::Authenticator.new(m).authenticate('pw')).to be_truthy
    end

    example '誤ったパスワードならfalseを返す' do
      m = build(:staff_member)
      expect(Baukis::Staff::Authenticator.new(m).authenticate('xy')).to be_falsey
    end

    example 'パスワード未設定ならfalseを返す' do
      m = build(:staff_member, password: nil)
      expect(Baukis::Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end

    example '開始前ならfalseを返す' do
      m = build(:staff_member, start_date: Date.tomorrow)
      expect(Baukis::Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end

    example '終了後ならfalseを返す' do
      m = build(:staff_member, end_date: Date.today)
      expect(Baukis::Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end
  end

end
