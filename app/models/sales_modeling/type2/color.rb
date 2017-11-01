class SalesModeling::Type2::Color
  attr_reader :code, :name

  def initialize(code, name)
    @code = code
    @name = name
  end

  def code
    @code.rjust(5,'0')
  end

  def hash
    self.hash
  end

  def valid?
    raise "Bad code format" unless code.length == 5
  end
end