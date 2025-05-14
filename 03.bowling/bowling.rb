#!/usr/bin/env ruby
# frozen_string_literal: true

arg_scores = ARGV[0].split(',')

def convert_to_int(str_array)
  str_array.map { |s| s.eql?('X') ? 10 : s.to_i }
end

arg_scores = convert_to_int(arg_scores)

final_score = 0
score_index = 0
flame_index = 0
while flame_index < 10
  if arg_scores[score_index].eql?(10)
    # ストライク
    final_score += 10 + arg_scores[score_index + 1] + arg_scores[score_index + 2]
    score_index += 1
  elsif arg_scores[score_index] + arg_scores[score_index + 1] == 10
    # スペア
    final_score += arg_scores[score_index] + arg_scores[score_index + 1] + arg_scores[score_index + 2]
    score_index += 2
  else
    final_score += arg_scores[score_index] + arg_scores[score_index + 1]
    score_index += 2
  end
  flame_index += 1
end

puts final_score
