require 'pry'
class PhoneNumber
  BAD_NUM = '0000000000'

  def initialize(phone_num)
    @phone_num = phone_num
  end

  def number 
    return BAD_NUM if @phone_num.match(/[a-z]/i)

    @phone_num = @phone_num.delete('^0-9')

    return BAD_NUM if bad_digit?
    
    @phone_num.size == 10 ? @phone_num : revised_num
  end

  def revised_num
    @phone_num[0] == '1' ? @phone_num[1,10] : BAD_NUM
  end

  def bad_digit?
     !%w(10 11).include? @phone_num.size.to_s
  end

  def area_code
    number[0,3]
  end

  def central_office_code
    number[3,3]
  end

  def line_code
    number[6,4]
  end

  def to_s
     '(' + area_code + ') ' + central_office_code + '-' + line_code
  end
end

# puts PhoneNumber.new('456.123.7890').number
# puts PhoneNumber.new('123-abc-1234').number
# puts PhoneNumber.new('(987) 654-3210').number
# puts PhoneNumber.new('(123) 456-7890').number
# puts PhoneNumber.new('21234567890').number
# puts PhoneNumber.new('9876543210').area_code

# puts PhoneNumber.new('5551234567').to_s
# # binding.pry
# puts PhoneNumber.new('11234567890').to_s