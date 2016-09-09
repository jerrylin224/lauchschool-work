flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.map! do |name|
  name[0, 3]
end


#anyway we use [beg_num,end_num] to invoke the index number of the array or string.
#For flintstones[0,4] will return string which index number start from 0 to 3
# => ["Fred", "Barney", "Wilma", "Betty"]
#So if we make it in string,ex:"Fred"[0,2],it will return "Fr".
#Therefore if we want to shorten each of these names to just 3 characters and return to array
#We must make it become string first to extract it for it's first 3 character,then return it to array
#So we need .map to make it into array after return,the also use block to extract the string
#flintstones.map! do |name| name[0, 3] end,it means invoke every srting in the array,
#but only print out the character of itself from index number 0 to 2(3 character),
#then make the new string become a new array.