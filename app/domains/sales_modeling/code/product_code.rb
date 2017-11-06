class SalesModeling::Code::ProductCode
  include SalesModeling::Code
  attr_reader :code
  CODE_LENGTH = 4

  def initialize(code)
    if code.slice(0) == 'p'
      @code = code.rjust(CODE_LENGTH,'0')
    else
      @code = "p#{code.rjust(CODE_LENGTH,'0')}"
    end
    valid?
  end

  def hash
    self.hash
  end

  def valid?
    raise "Not prodcut code format" unless @code.length == CODE_LENGTH + 1
    raise "Not prodcut code format" unless @code.slice(0) == 'p'
  end
end