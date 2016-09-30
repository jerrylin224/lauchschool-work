# Modify the following code so that I'm Sophie! is printed when puts kitty is invoked.

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "I'm #{name}"
  end
end

kitty = Cat.new('Sophie')
puts kitty

# every class has a #to_s method. This #to_s method is called every time #puts is invoked. 
# Knowing this, we can modify the output of #to_s to be whatever we want.