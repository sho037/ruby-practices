#!/usr/bin/env ruby
# frozen_string_literal: true

arg_scores = ARGV[0].split(',')

def to_frames(scores)
  shots = []
  scores.each do |s|
    s == 'X' ? shots.push(10, 0) : shots.push(s.to_i)
  end
  shots.each_slice(2).to_a
end

frames = to_frames(arg_scores)

final_score = 0

frames[0..9].each_with_index do |frame, index|
  final_score += frame.sum
  if frame[0] == 10
    if frames[index + 1][0] == 10
      final_score += 10 + frames[index + 2][0]
    else
      final_score += frames[index + 1].sum
    end
  elsif frame.sum == 10
    final_score += frames[index + 1][0]
  end
end

puts final_score
