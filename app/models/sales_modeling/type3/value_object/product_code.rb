class SalesModeling::Type3::ValueObject::ProductCode
  attr_reader :code

  def initialize(code)
    if code.slice(0) == 'p'
      @code = code.rjust(4,'0')
    else
      @code = "p#{code.rjust(4,'0')}"
    end
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