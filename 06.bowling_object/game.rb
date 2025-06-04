# frozen_string_literal: true

require_relative './frame'

class Game
  def initialize(frames)
    @frames = frames
  end

  def score
    final_score = @frames[0..8].each_with_index.sum do |frame, index|
      score = frame.sum
      score + Frame.calc_bonus(frame, @frames[index + 1..])
    end
    final_score + @frames.last.sum
  end
end
