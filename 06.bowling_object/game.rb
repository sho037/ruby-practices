# frozen_string_literal: true

require_relative './frame'

class Game
  def initialize(frames)
    @frames = frames
  end

  def score
    final_score = @frames[0..8].each_with_index.sum { |frame, i| frame.score(@frames[i + 1], @frames[i + 2]) }
    final_score + @frames.last.base_score
  end
end
