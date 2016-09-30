# Using the following code, add the appropriate accessor methods so that @name is capitalized 
# upon assignment.

class Person
  attr_reader :name

  def name=(person_name)
    @name = person_name.capitalize
  end

end

person1 = Person.new
person1.name = 'eLiZaBeTh'
puts person1.name


# Try to teach you to manually set the setter method.