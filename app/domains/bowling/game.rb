module Bowling
  class Game
    def initialize
      @its_score = 0
      @current_throw = 0
      @its_throws = Array.new(21,0)
    end

    def score
      @its_score
    end

    def add(pins)
      @its_throws[@current_throw] =  pins
      @current_throw += 1
      @its_score += pins
    end

    def score_for_frame(the_frame)
      score = 0
      ball = 0
      current_frame = 0
      while  current_frame < the_frame
        score += @its_throws[ball] + @its_throws[ball+1]
        ball += 2
        current_frame += 1
      end
      score
    end
  end
end