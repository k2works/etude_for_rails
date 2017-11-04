module SalesModeling
  module Code
    extend ActiveSupport::Concern
    attr_reader :code, :name
    CODE_LENGTH = 5

    def initialize(code, name)
      @code = code.rjust(CODE_LENGTH,'0')
      @name = name
      valid?
    end

    def hash
      self.hash
    end

    def valid?
      raise "Invalid code format" unless code.length == CODE_LENGTH
    end
  end
end
