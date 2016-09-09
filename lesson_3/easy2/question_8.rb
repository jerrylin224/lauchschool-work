flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.index {|name| name[0, 2] == "Be" }
flintstones.index("Fred")

#dont get it.
#a = [ "a", "b", "c" ]
#a.index("b")              #=> 1
#a.index("z")              #=> nil
#a.index { |x| x == "b" }  #=> 1
#So basically .index is used to get the index number of certain string.
#This question ask to find out the number of the string whose first two character contaion "Be"
#Therefore we can follow the example of the "a.index { |x| x == "b" }  #=> 1"
#and use[0,2] to find the first two character which fit Be