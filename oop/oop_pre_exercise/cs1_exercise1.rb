class MyCar

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model    
    @current_speed = 0
  end

  def speed_up(num)
    @current_speed += num
    "You speed up the car #{@current_speed} mph."
  end

  def brake(num)
    @current_speed -= num
    "You push the brake and deaccelerate #{@current_speed} mph."
  end

  def shut_car
    @current_speed = 0
    "You shut yor car down."
  end

  def current_speed
    @current_speed 
    "Now the current speed is #{@current_speed} mph"
  end

end

Tesla = MyCar.new(2013, 'red', 'Model S')

puts Tesla.current_speed

puts Tesla.speed_up(40)
puts Tesla.current_speed

puts Tesla.brake(20)
puts Tesla.current_speed

puts Tesla.shut_car
puts Tesla.current_speed
