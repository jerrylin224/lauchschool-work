module Affordable
  def price
    puts "I am not so expansive."
  end
end

class Vehicle
  @@number_of_vehicles = 0

  attr_accessor :color, :model
  attr_reader :year

  def self.number_of_vehicles
    puts "This program has created #{@@number_of_vehicles} vehicles"
  end    

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model    
    @current_speed = 0
    @@number_of_vehicles += 1  
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

  def age
    "Your #{self.model} is #{years_old} years old."
  end

  private

  def years_old
    Time.now.year - self.year
  end



end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2
end

class MyCar < Vehicle
  include Affordable
  NUMBER_OF_DOORS = 4
end


Tesla = MyCar.new(2011, 'red', 'Model S')
Vehicle.number_of_vehicles
puts Tesla.age
