class SalesModeling::Type2::ProductCode
  attr_reader :code

  def initialize(code)
    @code = code
    valid?
  end

  def hash
    self.hash
  end

  def valid?
    raise "Not prodcut code format" unless @code.length == 10
  end
end