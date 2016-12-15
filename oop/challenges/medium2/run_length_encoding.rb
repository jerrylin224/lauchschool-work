


# module RunLengthEncoding
#   def encode(input)
#     input.gsub(/(.)\1+/) { |match| match.size.to_s + match[-1] }
#   end

#   def decode(input)
#     input.gsub(/\d+\D/) { |match| match[-1] * match.to_i }
#   end
# end


# 之後試著用古老的方法推演



module RunLengthEncoding
  def self.encode(input)
    input.gsub(/(.)\1+/) { |match| match.size.to_s + match[0] }
  end

  def self.decode(input)
    input.gsub(/\d+\D/) { |match| match[-1] * match.to_i}
  end
end