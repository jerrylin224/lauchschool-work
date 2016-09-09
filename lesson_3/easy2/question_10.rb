flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.map! {|name| name[0, 3] }
#anyway we use [beg_num,end_num] to invoke the index number of the array or string.
#For flintstones[0,4] will return string which index number start from 0 to 3
# => ["Fred", "Barney", "Wilma", "Betty"]
#So if we make it in string,ex:"Fred"[0,2],it will return "Fr".
#Therefore if we want to shorten each of these names to just 3 characters -- 
#but this time do it all on one line:
