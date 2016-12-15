class Tinary

  def initialize(str)
    @tinary = str
  end

  # def to_decimal
    
  # end

  def convert_to_tinary
    result = @tinary.chars.map do |char|
      if char =~ /[0-2]/
        char.to_i
      else
        0
      end
    end

    result
  end

  def conver_to_right_value
    convert_to_tinary.reverse.each_with_index.map do |num, idx|
      num^idx * nim
  end
end

tinary = Tinary.new("102315")
