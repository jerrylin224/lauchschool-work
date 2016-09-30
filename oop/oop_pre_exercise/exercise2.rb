module Speak
  def speak
    "Some information."
  end
end

class MyClass
  include Speak
end

my_obj = MyClass.new

puts my_obj.speak



