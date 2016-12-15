require 'pry'
class School
  def initialize
    @list = Hash.new { |hash, key| hash[key] = [] }
  end

  def add(name, grade)
    @list[grade].push(name).sort!  
  end

  def grade(num)
    @list[num]
  end

  def to_h
    @list.sort.to_h
  end
end


# @list[grade].push(name).sort!  這有點強。因為既然@list[grade] 是一個array，
# 那你就可以直接接push，把string push進去，接著再直接sort裡面的string，強！
# @list = Hash.new { |hash, key| hash[key] = [] }
#  @list.sort.to_h