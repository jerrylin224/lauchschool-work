munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

#So it should use something like iterate to go through all the hash,and try to check
#the age of each value.And after that make a new key-value pair in the same time.


munsters.each do |name, details|
  case details["age"]
  when 0...18
    details["age_group"] = "kid"
  when 18...65
    details["age_group"] = "adult"
  else
    details["age_group"] = "senior"
  end
end
#can't add a new key into hash during iteration (RuntimeError)
#Why the hash name here is not munster but details?

#So how it evaluate the value?
#I dont know why only 0..18,the the value can know it fit or not?

#So details["age"] will show the number of value,but how?
#case 79
#when 1..50   then   print "low\n"
#when 51..75  then   print "medium\n"
#when 76..100 then   print "high\n"
#end

#and why the parameter can directly be evaluated by the case statement

#when you return or iterate thorugh the hase
