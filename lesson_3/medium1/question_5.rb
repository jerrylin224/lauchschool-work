def factors(number)
  dividend = number
  divisors = []
  begin
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end until dividend == 0
  divisors
end

factors(1

#Solution
while dividend > 0 do
  divisors << number / dividend if number % dividend == 0
  dividend -= 1
end


#Bonus 1:divisors << number / dividend if number % dividend == 0
#So if dont fit the condition,it will pass it and subsract one and run the loop again
#So it will keep substract the when number % dividend == 0 it will push it quotient in to divisors.

#Bonus2:If we don't have it,the return value of the method would be nil.