class PerfectRails::Money
  attr_reader :amount, :currency

  def initialize(amount, currency = "JPY")
    @amount = amount
    @currency = currency
  end

  def ==(other)
    amount == other.amount && currency == other.currency
  end

  def +(other)
    raise "Currency is different" unless currency == other.currency

    PerfectRails::Money.new(amount + other.amount, currency)
  end

  def -(other)
    raise "Currency is different" unless currency == other.currency
    raise "Other money is bigger than self" if amount < other.amount

    PerfectRails::Money.new(amount - other.amount, currency)
  end
end