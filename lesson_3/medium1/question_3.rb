puts "the value of 40 + 2 is " + (40 + 2).to_s

puts "the value of 40 + 2 is #{(40 + 2)} "

"#{}"
#Interpolation[edit]:call a object then won't be affected?
#Interpolation allows Ruby code to appear within a string. The result of evaluating that code is inserted into the string:

#{}"1 + 2 = #{1 + 2}"    #=> "1 + 2 = 3" 