class Crypto
  def initialize(words)
    @normalize_plaintext = words.gsub(/\W/, '').downcase
  end

  def normalize_plaintext
    @normalize_plaintext
  end

  def size
    Math.sqrt(normalize_plaintext.size).ceil
  end

  def plaintext_segments
    normalize_plaintext.scan(/.{1,#{size}}/)
  end

  def ciphertext
    encode_plaintext
  end

  def normalize_ciphertext
    encode_plaintext(" ")
  end

  def encode_plaintext(delimiter='')
    plaintext_segments.map{ |array| array.ljust(size)}
              .map(&:chars)
              .transpose              
              .map(&:join)
              .map(&:strip)
              .join(delimiter)
  end
end


# def encode_plaintext(delimiter='')
#   padded_segments = plaintext_segments.map { |string| right_pad(string, size) }
# end

# zomg
# zomb
# ies

# crypto = Crypto.new('1234')
# puts crypto.normalize_plaintext
# puts crypto.size
# crypto = Crypto.new('Oh hey, this is nuts!')
# puts crypto.size
#  crypto = Crypto.new('123456789')
#  puts crypto.size
# crypto = Crypto.new('ZOMG! ZOMBIES!!!')
# puts crypto.normalize_plaintext
# puts crypto.size
# crypto = Crypto.new('We all know interspecies romance is weird.')
# puts crypto.size
# puts crypto.normalize_plaintext
# p crypto.plaintext_segments

# crypto = Crypto.new('Madness, and then illumination.')
# puts crypto.normalize_plaintext
# p crypto.ciphertext
# # p crypto.plaintext_segments
# puts crypto.normalize_ciphertext
# ciphertext

# puts crypto.size
# puts crypto.normalize_ciphertext

# array = ["ifmanwas",
# "meanttos",
# "tayonthe",
# "groundgo",
# "dwouldha",
# "vegivenu",
# "sroots",]