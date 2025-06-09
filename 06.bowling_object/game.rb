# frozen_string_literal: true

require_relative './frame'

class Game
  def initialize(frames)
    @frames = frames
  end

  def score
    final_score = @frames[0..8].each_with_index.sum do |frame, index|
      score = frame.sum
      score + frame.calc_bonus(@frames[index + 1], @frames[index + 2])
    end
    final_score + @frames.last.sum
  end
end
