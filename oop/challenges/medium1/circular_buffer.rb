require 'pry'
class CircularBuffer
  def initialize(size)
    @size = size
    @buffer = []
  end

  def read
    @buffer.empty? ? raise(BufferEmptyException) : @buffer.shift
  end

  def write(element)
    return if element.nil?
    full? ? raise(BufferFullException) : @buffer.push(element)
  end

  def write!(element)
    return if element.nil?
    @buffer.shift if full?
    @buffer.push(element)
  end

  def full?
    @buffer.size == @size
  end

  def clear
    @buffer.clear
  end

  class BufferEmptyException < StandardError; end
  class BufferFullException < StandardError; end
end