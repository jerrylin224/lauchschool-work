  class MyCar
  attr_accessor :color, :model
  attr_reader :year

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

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end

  def self.gas_mileage(gallons, miles) 
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def to_s
    "You have a #{color}, #{model}, #{year}."    
  end
end

Tesla = MyCar.new(2013, 'red', 'Model S')


puts Tesla


