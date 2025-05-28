# frozen_string_literal: true

class Game
  def initialize(frames)
    @frames = frames
  end

  def score
    score = 0

    @frames[0..9].each_with_index do |frame, index|
      score += frame.sum
      next unless frame.spare?

      score += @frames[index + 1].first.score
      next unless frame.strike?

      score +=
        if @frames[index + 1].strike?
          @frames[index + 2].first.score
        else
          @frames[index + 1].second.score
        end
    end

    score
  end
end
