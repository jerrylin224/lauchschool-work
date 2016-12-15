class PerfectNumber
  def self.classify(num)
    raise RuntimeError, 'Only number is greater than 0 valid' if num < 0

    sum = (1...num).select { |n| num % n == 0}.reduce(:+)

    return "abundant"  if num < sum
    return "deficient" if num > sum
    return "perfect"   if num == sum
  end
end

# puts PerfectNumber.classify(13)
# puts PerfectNumber.classify(28)
# puts PerfectNumber.classify(12)
# puts PerfectNumber.classify(-1)





























# class PerfectNumber
#   def self.classify(num)
#     raise RuntimeError if num < 0
    
#     sum = (1...num).select { |n| num % n == 0 }.reduce(:+)

#     case
#     when sum < num then "deficient"
#     when sum > num then "abundant"
#     else                "perfect"
#     end
#   end


# end


