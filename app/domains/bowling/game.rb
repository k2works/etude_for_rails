module Bowling
  class Game
    def initialize
      @its_score = 0
      @its_current_throw = 0
      @its_throws = Array.new(21,0)
      @its_current_frame = 1
      @first_throw = true
    end

    def score
      score_for_frame(get_current_frame-1)
    end

    def add(pins)
      @its_throws[@its_current_throw] =  pins
      @its_current_throw += 1
      @its_score += pins

      adjust_current_frame(pins)
    end

    def score_for_frame(the_frame)
      score = 0
      @ball = 0
      current_frame = 0
      while  current_frame < the_frame
        if strike
          @ball += 1
          score += 10 + next_two_balls
        else
          score += handle_second_throw
        end
        current_frame += 1
      end
      score
    end

    def get_current_frame
      @its_current_frame
    end

    private
    def strike
      @its_throws[@ball] == 10
    end

    def next_two_balls
      @its_throws[@ball] + @its_throws[@ball+1]
    end

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

    def handle_second_throw
      score = 0

      # スペアの得点計算には次のフレームの第１投が必要
      if spare
        @ball += 2
        score += 10 + next_ball
      else
        score += two_balls_in_frame
        @ball += 2
      end
      score
    end

    def spare
      @its_throws[@ball] + @its_throws[@ball+1] == 10
    end

    def next_ball
      @its_throws[@ball]
    end

    def two_balls_in_frame
      @its_throws[@ball] + @its_throws[@ball+1]
    end
  end
end