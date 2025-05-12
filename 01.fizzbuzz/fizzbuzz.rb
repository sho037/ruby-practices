def print_fizzbuzz(start, finish)
  (start..finish).each do | index |
    flag = false
    if index % 3 == 0
      print "Fizz"
      flag = true
    end

    if index % 5 == 0
      print "Buzz"
      flag = true
    end
    
    if flag
      puts
    else
      puts index
    end
  end
end

print_fizzbuzz 1, 20
