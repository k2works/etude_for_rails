module Bowling
  class Game
    def initialize
      @its_current_frame = 1
      @first_throw = true
      @its_scorer = Scorer.new
    end

    def score
      score_for_frame(@its_current_frame)
    end

    def add(pins)
      @its_scorer.add_throw(pins)
      adjust_current_frame(pins)
    end

    def score_for_frame(the_frame)
      @its_scorer.score_for_frame(the_frame)
    end

    private
    def adjust_current_frame(pins)
      if last_ball_in_frame(pins)
        advance_frame
      else
        @first_throw = false
      end
    end

    def last_ball_in_frame(pins)
      strike(pins) || !@first_throw
    end

    def strike(pins)
      @first_throw && pins == 10
    end

    def advance_frame
      @its_current_frame = [10, @its_current_frame+1].min
    end
  end
end