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
      if @first_throw
        if !adjust_frame_for_strike(pins)
          @first_throw = false
        end
      else
        advance_frame
        @first_throw = true
      end
    end

    def adjust_frame_for_strike(pins)
      if pins == 10
        advance_frame
        true
      else
        false
      end
    end

    def advance_frame
      @its_current_frame = [10, @its_current_frame+1].min
    end
  end
end