statement = "The Flintstones Rock"

result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a
letters.each do |letter|
  letter_frequency = statement.scan(letter).count
  result[letter] = letter_frequency if letter_frequency > 0
end

#Impressive...
#.to_a is to make sth into array
#So we want to count the frequency of each letter,and we can use scan to do it.
#But the new problem here is,how to make each letter and it frequency into key-value pair?
#Always consider use block to help you solve the problem
#So we use a block which will contain things like hash[letter] = letter_frequency
#We can know the frequency through .scan.count to help us,but how can we make those letter and frequency into hash?
#It we do it one by one,it will cost too much time,so we can use sth to help us check 1 by 1.
#Then you can use frequency and each to help you.Only those frequency is bigger than 0 can be added.
#So use each to check 1 by 1,but remember to add ('A..Z') and ('a..z') together.