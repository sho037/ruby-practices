def print_fizzbuzz(start, finish)
  (start..finish).each do | index |
    print_index_flag = true
    if index % 3 == 0
      print "Fizz"
      print_index_flag = false
    end

    if index % 5 == 0
      print "Buzz"
      print_index_flag = false
    end
    
    print index if print_index_flag
    puts
  end
end

print_fizzbuzz 1, 20
