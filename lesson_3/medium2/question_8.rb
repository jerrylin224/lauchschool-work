def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end

puts bar
#The return value of method foo will always be yes,so when you use foo as parameter,it will not equal to "no"
#So the return value of bar(foo) will be "now"