require 'pry'
class Octal
  def initialize(str)
    @digits = str.chars
  end

  # def to_decimal
  #   return 0 if @digits.any? { |digit| digit =~ /[^0-7]/ }
  #   @digits.reduce(0) { |sum, num| (sum + num.to_i) * 8 } / 8
  # end

  def to_decimal
    return 0 if @digits.any? { |digit| digit.match(/[^0-7]/) }
    @digits.reduce(0) { |sum, num| (sum + num.to_i) * 8 } / 8
  end


  # def to_decimal
  #   return 0 if @digits.any? { |digit| digit.match(/[^0-7]/) }
  #   @digits.reverse
  #          .map(&:to_i)
  #          .map.with_index { |value, index| value * (8**index) }.reduce(:+)
  # end
end  
# 所以initialize會生成octal的數字
# to_decimal會把數字變回decimal
# 但測試的時候會把invalid octal變成零，所以在initialize的時候會需要處理
  # def check_string(string)
  #   result = []
  #   string.chars.each do |char|
  #     char.match(/[^1-7]/) ? return nil : result << char
  #   end

  #   result
  # end

  puts Octal.new('2047').to_decimal
  puts Octal.new('carrot').to_decimal
  puts Octal.new('9').to_decimal
  puts Octal.new('7777').to_decimal