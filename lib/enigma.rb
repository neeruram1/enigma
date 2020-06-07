require 'date'
require_relative 'shift'
require_relative 'key'
require_relative 'offset'

class Enigma
  attr_reader :numbers,
              :alphabet,
              :key,
              :date,
              :message,
              :shift

  def initialize
    #MAKE MODULE
    @numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
  end

  def encrypt(message, key = Key.new.randomize_key, date = Offset.new.date)
    @message = message
    @key = key
    @date = date
    @shift = Shift.new(@key, @date)
    {encryption: encode, key: @key, date: @date}
    binding.pry
  end

  def decrypt(message, key, date = create_date)
    @message = message
    @key = key
    @date = date
    {decryption: decode, key: @key, date: @date}
  end

#MAKE A MODULE
  def create_date
    Date.today.strftime("%d%m%y")
  end

  def decode
    a_rotated_alphabet = @alphabet.rotate(@shift.shift_values[:A] * -1)
    a_shift_alpha = Hash[@alphabet.zip a_rotated_alphabet]

    b_rotated_alphabet = @alphabet.rotate(@shift.shift_values[:B] * -1)
    b_shift_alpha = Hash[@alphabet.zip b_rotated_alphabet]

    c_rotated_alphabet = @alphabet.rotate(@shift.shift_values[:C] * -1)
    c_shift_alpha = Hash[@alphabet.zip c_rotated_alphabet]

    d_rotated_alphabet = @alphabet.rotate(@shift.shift_values[:D] * -1)
    d_shift_alpha = Hash[@alphabet.zip d_rotated_alphabet]

    message_chars = start_positions
    message_chars.map do |position, character|
      if @alphabet.include?(message_chars[position]) && position % 4 == 1
        message_chars[position] = a_shift_alpha[character]
      elsif @alphabet.include?(message_chars[position]) && position % 4 == 2
        message_chars[position] = b_shift_alpha[character]
      elsif @alphabet.include?(message_chars[position]) && position % 4 == 3
        message_chars[position] = c_shift_alpha[character]
      elsif @alphabet.include?(message_chars[position]) && position % 4 == 0
        message_chars[position] = d_shift_alpha[character]
      end
    end
    message_chars.values.join.chomp
  end
end
