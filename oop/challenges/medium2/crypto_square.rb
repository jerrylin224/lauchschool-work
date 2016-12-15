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