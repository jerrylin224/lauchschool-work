munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" }
}

total_male_age = 0


#My answer
munsters.each do |name, details|
  case details["gender"]
  when "male"
    total_male_age += details["age"]  
  else
  end
end

#Solution
munsters.each do |name, details|
  total_male_age += details["age"] if details["gender"] == "male"
  end
end
#Call the value
total_male_age


#Note:At first we need to filter out male,then sum the value of their age.
#So we need if or case to check wheher the value of details["age"] == "male" or not.
#If it fit,we sum it up by total_male_age += details["age"]  .
#But remember to add a variable out side of the scope.
