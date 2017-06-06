module Bowling
  class Game
    def initialize
      @its_current_frame = 1
      @first_throw = true
      @its_scorer = Scorer.new
    end

    def score
      score_for_frame(get_current_frame-1)
    end

    def add(pins)
      @its_scorer.add_throw(pins)
      adjust_current_frame(pins)
    end

    def score_for_frame(the_frame)
      @its_scorer.score_for_frame(the_frame)
    end

    def get_current_frame
      @its_current_frame
    end

    private
    def adjust_current_frame(pins)
      if @first_throw
        if pins == 10 # ストライク
          @its_current_frame += 1
          @first_throw = true
        else
          @first_throw = false
        end
      else
        @its_current_frame += 1
        @first_throw = true
      end
      @its_current_frame = [11, @its_current_frame].min
    end
  end
end