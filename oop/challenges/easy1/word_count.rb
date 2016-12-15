# class Phrase
#   def initialize(words)
#     @words = words
#   end

#   def word_count
#     count = Hash.new(0)

#     @words.scan(/\b[\w']+\b/).each { |word| count[word.downcase] += 1 }
#     count
#   end
# end

class Phrase
  def initialize(words)
    @words = words
  end

  def word_count
    @words.scan(/\b[\w']+\b/)
          .each_with_object(Hash.new(0)){ |word, hash| hash[word.downcase] += 1}
  end
end