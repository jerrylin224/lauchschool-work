

=>My string looks like this now: pumpkins
=>My array looks like this now: ["pumpkins", "rutabaga"]

#Because += is not mutataing,and << is mutating.
#The value will change depends on the return value.If the return value is different it will change,and vice versa.

def tricky_method(a_string_param)
  a_string_param += "rutabaga"
end

my_string = "pumpkins"
tricky_method(my_string)


Check later