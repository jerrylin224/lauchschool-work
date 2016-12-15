class Anagram
  def initialize(word)
    @word = word.downcase
  end

  def match(array)
    array.select { |word| anagrams?(word) }
  end

  def anagrams?(word)
    word.downcase.chars.sort == @comparison.downcase.chars.sort &&
    word.downcase != @word
  end
end

# input: string
# output: string
# rule: input a string and find out whether there is any string has the exactly character(case won't affect)


# Anagram.new('master')
# detector = Anagram.new('master')
# puts anagrams = detector.match(%w(stream pigeon maters))

# detector = Anagram.new('good')
# p detector.match(%w(dog goody))

detector = Anagram.new('listen')
anagrams = detector.match %w(enlists google inlets banana)
puts anagrams

detector = Anagram.new('allergy')
anagrams = detector.match %w( gallery ballerina regally clergy largely leading)
puts anagrams


detector = Anagram.new('corn')
anagrams = detector.match %w(corn dark Corn rank CORN cron park)
puts anagrams

# 善用argument真的很強啊.....
# 要比較的是單個文字，所以就把這個字放在argument中，再把這個method放在iterate的block中，最後剛好一致