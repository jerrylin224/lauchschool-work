require 'pry'
class Luhn
  def initialize(num)
    @num = num.to_s.chars.map(&:to_i)
  end

  def addends
    result = 
    if @num.size.odd?
      @num.map.with_index { |num, index| index.odd? ? num * 2 : num}
    else 
      @num.map.with_index { |num, index| index.even? ? num * 2 : num}
    end

    result.map { |num| num > 9 ? (num % 10) + 1 : num }
  end

  def checksum
    addends.reduce(:+)
  end

  def valid?
    (checksum % 10).zero?
  end

  def self.create(num)
    new_object = Luhn.new(num*10).addends
    remainder = new_object.reduce(:+) % 10
    num = remainder == 0 ? num * 10 : num * 10 + (10 - remainder)
  end
end