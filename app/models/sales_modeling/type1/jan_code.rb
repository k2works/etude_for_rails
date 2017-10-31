class SalesModeling::Type1::JANCode
  attr_reader :code,:country_code,:maker_code,:product_item_code,:check_digit

  def initialize(code)
    @code = code
    valid?
    @country_code = @code.slice(0,2)
    @maker_code = @code.slice(3,7)
    @product_item_code = @code.slice(9,3)
    @check_digit = @code.slice(12,1)
  end

  def hash
    self.hash
  end

  def valid?
    raise "Not JAN code format" unless @code.length == 13
  end
end