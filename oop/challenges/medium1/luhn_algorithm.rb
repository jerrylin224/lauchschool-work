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


# p Luhn.new(12_121).addends

# p Luhn.new(1230).addends
# puts ""
# puts Luhn.create(123)
# puts ""

# 右邊第一個數字都不會被影響，所以丟一個零進去，再看缺多少加多少。我的方法是乘以10加那個數字啦