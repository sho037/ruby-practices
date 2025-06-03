# frozen_string_literal: true

require_relative './shot'

class Frame
  attr_reader :first, :second

  def initialize(first, second)
    @first = Shot.new(first)
    @second = Shot.new(second || 0)
  end

  def strike?
    @first.score == 10
  end

  def spare?
    @first.score + @second.score == 10
  end

  def sum
    @first.score + @second.score
  end
end
