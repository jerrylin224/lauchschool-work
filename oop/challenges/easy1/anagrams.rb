class Anagram
  def initialize(word)
    @word = word.downcase.chars
  end

  def match(array)
    array.select do |element|
      next if element.downcase.chars == @word
      anagram?(element)
    end
  end

  def anagram?(element)
    element.downcase.chars.sort == @word.sort
  end
end















# class Anagram
#   def initialize(word)
#     @word = word.downcase
#   end

#   def match(array)
#     array.select { |word| anagrams?(word) }
#   end

#   def anagrams?(word)
#     word.downcase.chars.sort == @comparison.downcase.chars.sort &&
#     word.downcase != @word
#   end
# end

# # input: string
# # output: string
# # rule: input a string and find out whether there is any string has the exactly character(case won't affect)


# # 善用argument真的很強啊.....
# # 要比較的是單個文字，所以就把這個字放在argument中，再把這個method放在iterate的block中，最後剛好一致

