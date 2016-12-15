# class Trinary
#   attr_reader :trinary

#   def initialize(string)
#     @trinary = string
#   end


#   def to_decimal
#     return 0 if invalid_trinary?
#     numbers = @trinary.reverse.chars.map(&:to_i)
#     numbers.each_with_index.map { |num, idx| 3**idx * num }.inject(:+)
#   end

#   private 

#   def invalid_trinary?
#     @trinary.match(/[^0-2]/)
#   end
# end


class Trinary
  def initialize(input)
    @value = input.match(/[^0-2]/) ? '0' : input
  end

  def to_decimal
    @value.chars.inject(0) { |sum, num| (sum + num.to_i) * 3 } / 3
  end
end

# puts Trinary.new('222').to_decimal
# puts Trinary.new('112').to_decimal
# puts Trinary.new('1122000120').to_decimal
# puts Trinary.new('carrot').to_decimal
# puts Trinary.new('0a1b2c').to_decimal