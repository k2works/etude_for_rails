require 'rails_helper'

describe DesignPattern::Proxy::BankAccount do
  let(:account) { DesignPattern::Proxy::BankAccount.new(100) }

  describe '#deposit' do
    it 'add amount balance' do
      account.deposit(50)
      expect(account.balance).to eq(150)
    end
  end

  describe '#withdraw' do
    it 'subtract amount balance' do
      account.withdraw(10)
      expect(account.balance).to eq(90)
    end
  end

  context 'using proxy' do
    describe '#deposit' do
      it 'add amount balance' do
        proxy = DesignPattern::Proxy::BankAccountProxy.new(account)
        proxy.deposit(50)
        expect(proxy.balance).to eq(150)
      end
    end

    describe '#withdraw' do
      it 'subtract amount balance' do
        proxy = DesignPattern::Proxy::BankAccountProxy.new(account)
        proxy.withdraw(10)
        expect(proxy.balance).to eq(90)
      end
    end
  end

  context 'using protection proxy' do
    describe '#balance' do
      it 'not raise exception' do
        proxy = DesignPattern::Proxy::AccountProtectionProxy.new(account,'Tom')
        expect { proxy.balance }.not_to raise_exception
      end

      it 'raise exception' do
        proxy = DesignPattern::Proxy::AccountProtectionProxy.new(account,'Dom')
        expect { proxy.balance }.to raise_exception
      end
    end
  end
end