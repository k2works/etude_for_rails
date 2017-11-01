class SalesModeling::Type3::ValueObject::ProductCode
  attr_reader :code

  def initialize(code)
    @code = code
    valid?
  end

  def hash
    self.hash
  end

  def valid?
    raise "Not prodcut code format" unless @code.length == 5
    raise "Not prodcut code format" unless @code.slice(0) == 'p'
  end
end