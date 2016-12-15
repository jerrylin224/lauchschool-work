require 'pry'
class Clock
  def initialize(hour, minute)
    @hour = hour
    @minute = minute
  end

  def self.at(hour, minute = 0)
    Clock.new(hour, minute)
  end

  def to_s
    format('%02d:%02d', @hour, @minute)
  end

  def ==(other_clock)
    self.to_s == other_clock.to_s
  end

  def +(other)
    change!(other)
  end

  def -(other)
    change!(-other)
  end

  def change!(other)
    @minute += other % 60
    @hour += other / 60
    @hour %= 24
    self
  end
end

  def +(num)
    extra_min = num % 60
    extra_hour = num / 60
    Clock.new((@hour += extra_hour) % 24,  @minute += extra_min)
  end

  def -(num)
    extra_min = -num % 60
    extra_hour = -num / 60
    Clock.new((@hour += extra_hour) % 24,  @minute += extra_min)
  end