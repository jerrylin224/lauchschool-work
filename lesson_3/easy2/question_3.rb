ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

ages.keep_if { |name,age| age < 100 }


#delete_if and keep_if have the exact opposite result when supplied with the same block:
#keep_if use to keep ceratin element when satisfy the condition.