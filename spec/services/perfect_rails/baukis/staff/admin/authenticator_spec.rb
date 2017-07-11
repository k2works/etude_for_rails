require 'rails_helper'

describe Baukis::Admin::Authenticator do
  describe '#authenticate' do
    example '正しいパスワードならtrueを返す' do
      m = build(:administrator)
      expect(Baukis::Admin::Authenticator.new(m).authenticate('pw')).to be_truthy
    end

    example '誤ったパスワードならfalseを返す' do
      m = build(:administrator)
      expect(Baukis::Admin::Authenticator.new(m).authenticate('xy')).to be_falsey
    end

    example 'パスワード未設定ならfalseを返す' do
      m = build(:administrator, password: nil)
      expect(Baukis::Admin::Authenticator.new(m).authenticate('pw')).to be_falsey
    end
  end
end