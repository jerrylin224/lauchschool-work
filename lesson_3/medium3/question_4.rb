def tricky_method_two(a_string_param, an_array_param)
  a_string_param << 'rutabaga'
  an_array_param = ['pumpkins', 'rutabaga']
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method_two(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

Check later

#Why it doesn't affect the value of my_array?Isn't the return value of my_array of the tricky_method_two(my_string, my_array)
#is ['pumpkins', 'rutabaga']?So when we redifine the variable,the value in method won't affect the original one?