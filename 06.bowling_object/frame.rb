# frozen_string_literal: true

require_relative './shot'

class Frame
  attr_reader :first, :second, :bonus, :is_final

  def self.calc_bonus(frame, behind_frames)
    return 0 unless frame.strike? || frame.spare?

    bonus = behind_frames[0].first.score
    return bonus unless frame.strike?

    bonus + if behind_frames[0].is_final || !behind_frames[0].strike?
              behind_frames[0].second.score
            else
              behind_frames[1].first.score
            end
  end

  def initialize(first, second, bonus, is_final)
    @first = first
    @second = second
    @bonus = bonus
    @is_final = is_final
  end

  def strike?
    @first.score == 10
  end

  def spare?
    [@first, @second].map(&:score).sum == 10 && !strike?
  end

  def sum
    [@first, @second, @bonus].map(&:score).sum
  end
end
