class SalesModeling::Type3::ValueObject::ProductType
  attr_reader :code, :name

  def initialize(code, name)
    @code = code.rjust(2,'0')
    @name = name
    valid?
  end

  def hash
    self.hash
  end

  def valid?
    raise "Bad code format" unless code.length == 2
  end
end