module Bowling
  class Scorer
    def initialize
      @its_current_throw = 0
      @its_throws = Array.new(21,0)
    end

    def add_throw(pins)
      @its_throws[@its_current_throw] = pins
      @its_current_throw += 1
    end

    def score_for_frame(the_frame)
      score = 0
      @ball = 0
      current_frame = 0
      while  current_frame < the_frame
        if strike
          score += 10 + next_two_balls_for_strike
          @ball += 1
        elsif spare
          score += 10 + next_ball_for_spare
          @ball += 2
        else
          score += two_balls_in_frame
          @ball += 2
        end

        current_frame += 1
      end
      score
    end

    private
    def strike
      @its_throws[@ball] == 10
    end

    def next_two_balls_for_strike
      @its_throws[@ball+1] + @its_throws[@ball+2]
    end

    def spare
      @its_throws[@ball] + @its_throws[@ball+1] == 10
    end

    def next_ball_for_spare
      @its_throws[@ball+2]
    end

    def two_balls_in_frame
      @its_throws[@ball] + @its_throws[@ball+1]
    end
  end
end