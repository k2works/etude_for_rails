class SalesModeling::Type3::ValueObject::SkuCode
  include SalesModeling::Code
  attr_reader :code
  CODE_LENGTH = 5

  def initialize(product_code,code)
    if code.length <= CODE_LENGTH
      @code = "#{product_code}-#{code.rjust(CODE_LENGTH,'0')}"
    else
      @code = code
    end

    valid?
  end

  def hash
    self.hash
  end

  def valid?
    raise "Not sku code format" unless @code.length == CODE_LENGTH + 6
    raise "Not sku code format" unless @code.slice(0) == 'p'
  end
end