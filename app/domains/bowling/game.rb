module Bowling
  class Game
    def initialize
      @its_score = 0
      @its_current_throw = 0
      @its_throws = Array.new(21,0)
    end

    def score
      @its_score
    end

    def add(pins)
      @its_throws[@its_current_throw] =  pins
      @its_current_throw += 1
      @its_score += pins
    end

    def score_for_frame(the_frame)
      score = 0
      ball = 0
      current_frame = 0
      while  current_frame < the_frame
        first_throw = @its_throws[ball]
        ball += 1
        second_throw = @its_throws[ball]
        ball += 1
        frame_score = first_throw + second_throw

        # スペアの得点計算には次のフレームの第１投が必要
        if frame_score == 10
          score += frame_score + @its_throws[ball]
        else
          score += frame_score
        end

        current_frame += 1
      end
      score
    end

    def get_current_frame
      1 + (@its_current_throw - 1) / 2
    end
  end
end