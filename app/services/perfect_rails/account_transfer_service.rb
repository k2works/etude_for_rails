module PerfectRails
  class AccountTransferService
    def initialize(from, to)
      @from = from
      @to = to
    end

    def transfer(money)
      Account.transaction do
        @from.balance -= money
        @from.save!

        @to.balance += money
        @to.save!
      end
    end
  end
end