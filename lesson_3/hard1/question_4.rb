def generate_UUID
  characters = []
  (0..9).each { |digit| characters << digit.to_s }
  ('a'..'f').each { |digit| characters << digit }

  uuid = ""
  sections = [8, 4, 4, 4, 12]
  sections.each_with_index do |section, index|
    section.times { uuid += characters.sample }
    uuid += '-' unless index >= sections.size - 1
  end

  uuid
end

#Very impressive.......
#We need to create a UUID,which consists of 32 hexadecimal characters, and is typically broken into 5 sections like this 8-4-4-4-12 and represented as a string.
#It will look like "f65c57f6-a6aa-17a8-faa1-a67f2dc9fa91".
#So the problem is how to do it...it is pretty hard,but I will explain the logic through the solution.
#1.The number in each section is made up of number 0 to 9 and character a to f randomly,so we need to put it together first,and call them randomly.
#Use .each and block to puch each number and character in it.
#2.Now we start to think about how to call number randomly and make it combine like "f65c57f6-a6aa-17a8-faa1-a67f2dc9fa91"
#The problem here is,(1)how to make sure every UUID is like 8-4-4-4-12
#Basically we can call number randomly to be a string in center number,for example,if I want to make a string which is made up of number 1 to 9 and the length is 10 digit?
#You have .sample can use,it will pick number from array randomly and turn it into string.
#Then,new more problem is,how to make it aligh for several number?

random_num = []
(1..9).each { |num| random_num << num.to_s } 

answer = " "
8.times { |a| answer << random_num.sample}
#so now,you can make a string which is made up of 8 random number.
#We can make one string like this now,but how can we make it in 5 sections like 8-4-4-4-12
#Therefore we need to use each,to make it to add number in 8,4,4,4 and 12 each times.
#you can imagie it will look like
answer = " "
8.times { |a| answer << random_num.sample}
4.times { |a| answer << random_num.sample}
4.times { |a| answer << random_num.sample}
4.times { |a| answer << random_num.sample}
4.times { |a| answer << random_num.sample}

#But if you do this you didn't seperate the number and it will be aweful,also,the code is too ugly.
#So let's modify it a little bit first.
answer = " "
8.times { |a| answer << random_num.sample}
answer += "-"
4.times { |a| answer << random_num.sample}
answer << "-"
4.times { |a| answer << random_num.sample}
answer << "-"
4.times { |a| answer << random_num.sample}
answer << "-"
12.times { |a| answer << random_num.sample}
puts answer
=>

