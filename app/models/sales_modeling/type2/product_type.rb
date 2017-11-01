class SalesModeling::Type2::ProductType
  attr_reader :code, :name

  def initialize(code, name)
    @code = code
    @name = name
  end

  def code
    @code.rjust(2,'0')
  end

  def hash
    self.hash
  end

  def valid?
    raise "Bad code format" unless code.length == 2
  end
end