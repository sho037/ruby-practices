# frozen_string_literal: true

require_relative './shot'

class Frame
  attr_reader :first, :second, :third

  def self.calc_bonus(frame, behind_frames)
    return 0 unless frame.strike? || frame.spare?

    bonus = behind_frames[0].first.score
    return bonus unless frame.strike?

    bonus + if behind_frames[0].third || !behind_frames[0].strike?
              behind_frames[0].second.score
            else
              behind_frames[1].first.score
            end
  end

  def initialize(first, second, third)
    @first = first
    @second = second
    @third = third
  end

  def strike?
    @first.score == 10
  end

  def spare?
    [@first, @second || Shot.new(0)].map(&:score).sum == 10 && !strike?
  end

  def sum
    [@first, @second || Shot.new(0), @third || Shot.new(0)].map(&:score).sum
  end
end
