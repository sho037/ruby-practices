# frozen_string_literal: true

def print_fizzbuzz(start, finish)
  (start..finish).each do |index|
    print 'Fizz' if (index % 3).zero?

    print 'Buzz' if (index % 5).zero?

    print index if index % 3 != 0 && index % 5 != 0
    puts
  end
end

print_fizzbuzz 1, 20
