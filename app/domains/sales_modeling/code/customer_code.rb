class SalesModeling::Code::CustomerCode
  include SalesModeling::Code
  attr_reader :code
  CODE_LENGTH = 4
  CODE_PREFIX = 'c'

  def initialize(code)
    if code.slice(0) == CODE_PREFIX
      @code = code.rjust(CODE_LENGTH,'0')
    else
      @code = "#{CODE_PREFIX}#{code.rjust(CODE_LENGTH,'0')}"
    end
    valid?
  end

  def hash
    self.hash
  end

  def valid?
    raise "Not #{self.class} code format" unless @code.length == CODE_LENGTH + 1
    raise "Not #{self.class} code format" unless @code.slice(0) == CODE_PREFIX
  end
end