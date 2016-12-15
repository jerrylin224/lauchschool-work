class Octal
  attr_reader :octal

  def initialize(string)
    @octal = check_string(string) 
  end

  def to_decimal
    length = @octal.size - 1
    sum = 0
    @octal.map.with_index do |oct, index| 
      sum += oct*8**(length - index) 
    end

    sum
  end

  private

  def check_string(string)
    result = []
    string.chars.each do |char|
      if char.match(/[^0-7]/)
        return [0]
      else 
        result << char.to_i
      end
    end

    result
  end
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

  # 所以目前為止的邏輯沒錯，