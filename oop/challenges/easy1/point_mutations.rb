require 'pry'

# class DNA
#   def initialize(strand)
#     @strand = strand.chars
#   end

#   def hamming_distance(distance)
#     result = distance.chars.select.with_index do |char, idx|
#       next if idx > @strand.size - 1
#       @strand[idx] != char
#     end.size
#   end
# end


class DNA
  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(distance)
      length = [@strand.size, distance.size].min
      return 0 if length == 0
      result = (0..length-1).select { |idx| @strand[idx] != distance[idx] }.size
  end
end

DNA.new('AAACTAGGGG').hamming_distance('AGGCTAGCGGTAGGAC')