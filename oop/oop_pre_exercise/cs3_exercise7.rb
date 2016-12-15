class Student

  def initialize(name, grade)
    @name = name
    @grade = grade    
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

   
  protected # 不能用private的原因是內部會出現object.grade（造成無法存取的原因），但如果是用#protected就沒差（可以出現class name）

  def grade
    @grade
  end
end

joe = Student.new('Joe', 90)
bob = Student.new('Bob', 60)
puts joe.grade
puts "Well done!" if joe.better_grade_than?(bob)