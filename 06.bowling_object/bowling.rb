#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './shot'
require_relative './frame'
require_relative './game'

def main
  arg_scores = ARGV[0].split(',')

  frames = to_frames(arg_scores.map { |as| Shot.new(as) })

  game = Game.new(frames)

  puts game.score
end

def to_frames(shots)
  frames = Array(0..8).map do
    first = shots.shift
    if first.strike?
      Frame.new(first, nil, nil)
    else
      Frame.new(first, shots.shift, nil)
    end
  end
  frames.push(Frame.new(shots[0], shots[1], shots[2]))
end

main
