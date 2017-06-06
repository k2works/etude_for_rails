module Bowling
  class Scorer
    def initialize
      @its_current_throw = 0
      @its_throws = Array.new(21,0)
    end
  end
end