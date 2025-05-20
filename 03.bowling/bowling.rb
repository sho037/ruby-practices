#!/usr/bin/env ruby
# frozen_string_literal: true

arg_scores = ARGV[0].split(',')

def to_integer_scores(str_array)
  str_array.map { |s| s == 'X' ? 10 : s.to_i }
end

score_list = to_integer_scores(arg_scores)

final_score = 0
score_index = 0
10.times do
  if score_list[score_index] == 10
    # ストライク
    final_score += 10 + score_list[score_index + 1] + score_list[score_index + 2]
    score_index += 1
  elsif score_list[score_index] + score_list[score_index + 1] == 10
    # スペア
    final_score += score_list[score_index] + score_list[score_index + 1] + score_list[score_index + 2]
    score_index += 2
  else
    final_score += score_list[score_index] + score_list[score_index + 1]
    score_index += 2
  end
end

puts final_score
