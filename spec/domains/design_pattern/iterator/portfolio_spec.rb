require 'rails_helper'

describe DesignPattern::Iterator::Portfolio do
  describe '#any?' do
    it 'check account balance' do
      my_portfolio = DesignPattern::Iterator::Portfolio.new
      ac = DesignPattern::Iterator::Account.new('Money', 3000)
      my_portfolio.add_account(ac)
      expect(my_portfolio.any? { |account| account.balance > 2000 }).to be true
    end
  end

  describe '#all?' do
    it 'check account balance' do
      my_portfolio = DesignPattern::Iterator::Portfolio.new
      ac = DesignPattern::Iterator::Account.new('Money', 20)
      my_portfolio.add_account(ac)
      expect(my_portfolio.all? { |account| account.balance >= 10 }).to be true
    end
  end
end
