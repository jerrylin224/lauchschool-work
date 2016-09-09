

def fib(first_num, second_num, limit_num)
  while second_num < limit_num
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(11, 2, 15)
puts "result is #{result}"

#Ben defines limit before he calls fib. But limit is not visible in the scope of fib because fib is a method and does not have access to any local variables outside of its scope.

#You can make limit an additional argument to the definition of the fib method and pass it in when you call fib.

#So,if you make limit_num another argument,then it can be access.