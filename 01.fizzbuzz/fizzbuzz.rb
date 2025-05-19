def print_fizzbuzz(start, finish)
  (start..finish).each do | index |
    if index % 3 == 0
      print "Fizz"
    end

    if index % 5 == 0
      print "Buzz"
    end
    
    print index if index % 3 != 0 && index % 5 != 0
    puts
  end
end

print_fizzbuzz 1, 20
