class SalesModeling::Type3::ValueObject::Year
  attr_reader :code, :name

  def initialize(code, name)
    @code = code.rjust(5,'0')
    @name = name
    valid?
  end

  def hash
    self.hash
  end

  def valid?
    raise "Invalid code format" unless @code.length == 5
  end
end