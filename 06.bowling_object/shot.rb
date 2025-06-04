# frozen_string_literal: true

class Shot
  attr_reader :score

  def self.strike?(socre)
    socre == 'X'
  end

  def initialize(score)
    @score = score
  end
end
