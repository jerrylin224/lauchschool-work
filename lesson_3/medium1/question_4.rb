numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end


#Not really get it,so when I print first number,the shift will delete the first n number of the rest array?
#For example I print 1,and the shift will delete the following n array,which start counting from 2.

#ok,if we use the following code to check,then we can find out the answer
numbers = [1, 2, 3, 4]
numbers.each_with_index do |number, index|
  p "#{index}  #{numbers.inspect}  #{number}"
  numbers.shift(1)
end

#we got 
#"0  [1, 2, 3, 4]  1"
#1  [2, 3, 4]  3"
#So we can know while we are iterating,the array is changing dynamically.
#The iterating process keep doing following the order of index number.
#We first iterate the index number 0,then it go to index number 1
#But after we shift the first number of the array,index number 0 became 1 and index number 1 become 2
#So it will print 3,not 4.

#In both cases we see that iterators DO NOT work on a copy of the original array or from stale meta-data (length) about the array. They operate on the original array in real time.


numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end