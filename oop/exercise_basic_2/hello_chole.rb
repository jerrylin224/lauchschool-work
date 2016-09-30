# Using the following code, add an instance method named #rename that renames kitty when invoked.

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def rename(name)
    @name = name    
  end
end

kitty = Cat.new('Sophie')
puts kitty.name
kitty.rename('Chloe')
puts kitty.name

# So weird...since we can use getter method,why should fo this?
# Or because this is just designed for practicing???But is is so nonsense.