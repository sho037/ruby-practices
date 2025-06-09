# frozen_string_literal: true

require_relative './shot'

class Frame
  attr_reader :first, :second, :third

  def initialize(first, second, third)
    @first = first
    @second = second
    @third = third
  end

  def strike?
    @first.score == 10
  end

  def spare?
    [@first, @second].compact.map(&:score).sum == 10 && !strike?
  end

  def base_score
    [@first, @second, @third].compact.map(&:score).sum
  end

  def calc_bonus(next_frame, after_next_frame)
    return 0 unless strike? || spare?

    bonus = next_frame.first.score
    return bonus unless strike?

    bonus + if next_frame.third || !next_frame.strike?
              next_frame.second.score
            else
              after_next_frame.first.score
            end
  end
end
