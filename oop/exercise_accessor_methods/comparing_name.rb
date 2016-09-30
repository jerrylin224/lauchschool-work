# Using the following code, add the appropriate accessor methods. Keep in mind that @last_name 
# shouldn't be visible outside the class.

class Person
  attr_writer :last_name
  attr_accessor  :first_name

  def first_equals_last?
    first_name == last_name
  end

  private

  attr_reader :last_name 

end

person1 = Person.new
person1.first_name = 'Dave'
person1.last_name = 'Smith'
puts person1.first_equals_last?

# Ask us to compare,but the value is not visible outsie.So we need a way to read it inside,
# but it couldn't be read outside.