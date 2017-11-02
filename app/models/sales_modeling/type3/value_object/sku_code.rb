class SalesModeling::Type3::ValueObject::SkuCode
  attr_reader :code

  def initialize(product_code,code)
    if code.length <= 5
      @code = "#{product_code}-#{code.rjust(5,'0')}"
    else
      @code = code
    end

    valid?
  end

  def hash
    self.hash
  end

  def valid?
    raise "Not sku code format" unless @code.length == 11
    raise "Not sku code format" unless @code.slice(0) == 'p'
  end
end