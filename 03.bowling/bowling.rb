#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './frame'
require_relative './game'

arg_scores = ARGV[0].split(',')

def to_frames(scores)
  shots = []
  scores.each do |s|
    s == 'X' ? shots.push(10, 0) : shots.push(s.to_i)
  end

  sliced_frames = shots.each_slice(2).to_a

  sliced_frames.map do |frame|
    Frame.new(frame[0], frame[1])
  end
end

frames = to_frames(arg_scores)

game = Game.new(frames)

puts game.score
