# class Triangle
#   def initialize(num_rows)
#     @num_rows = num_rows
#   end
  
#   def rows
#     triangle  = [[1]]
#     (@num_row - 1).times do
#       triangle << create_row(triangle.last)
#     end

#     triangle
#   end

#   def create_row(array)
#     row = ([0] + array).zip(array + [0])
#     row.collect { |num1, num2| num1 + num2 }
#   end
# end
class Triangle
  def initialize(levels)
    @levels = levels
  end

  def row(number)
    if number == 1
      [1]
    else
      next_row_for(row(number-1))
    end
  end

  def rows
    all_rows = []
    (1..@levels).each do |level|
      all_rows << row(level)
    end

    all_rows
    # (1..@levels).reduce([]) { |result, number| row(number) }
  end

  def next_row_for(current_row)
    result = []
    current_row.each_with_index do |number, index|
      result << 1 and next if index == 0
      result << number + current_row[index-1]
    end

    result << 1
  end
end

# [1], [1, 1] [1, 2, 1]
# row1 = [1]
# row2 = [row1[0], row1[0]]
# rwo3 = [row2[0], row2[0] + row2[1], row[1]]
# row4 = [row3[0], row3[0] + row3[1], row[1] + row[2], row[2]]

# rown = row(n-1)[0], row(n-1)[0] + row(n-1)[1], row(n-1)[1] + row(n-1)[2]....,row(n-1)[n-3] + row(n-1)[n-2], row(n-1)[n-2]
# create_row(array)
#   row = array

# 重點是可以用先前的array生成之後的array
# 之後寫題目前先花點時間好好思考題目在問什麼、algorithm是什麼
# 幹你老師既然這麼簡單！！！