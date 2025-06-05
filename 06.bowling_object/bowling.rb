#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './shot'
require_relative './frame'
require_relative './game'

def main
  arg_scores = ARGV[0].split(',')

  frames = to_frames(arg_scores)

  game = Game.new(frames)

  puts game.score
end

def to_frames(scores)
  shots = []
  break_index = 0
  scores.each_with_index do |score, index|
    break_index = index
    break if shots.size >= 18

    Shot.strike?(score) ? shots.push(Shot.new(10), Shot.new(0)) : shots.push(Shot.new(score.to_i))
  end

  sliced_frames = shots.each_slice(2).to_a
  sliced_frames << extract_bonus_shots(scores[break_index..])

  sliced_frames.map do |frame|
    Frame.new(frame[0], frame[1], frame[2] || Shot.new(0), frame[2] ? true : false)
  end
end

def extract_bonus_shots(bonus_scores)
  bonus_shots = bonus_scores.map do |s|
    Shot.strike?(s) ? Shot.new(10) : Shot.new(s.to_i)
  end

  [bonus_shots[0], bonus_shots[1], bonus_shots[2]]
end

main
