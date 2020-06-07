require 'date'
class Enigma
  attr_reader :numbers,
              :alphabet,
              :key,
              :date,
              :message
  def initialize
    @numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
    @alphabet = ("a".."z").to_a << " "
  end

  def encrypt(message, key = randomize_key, date = create_date)
    @message = message
    @key = key
    @date = date
    {encryption: encode, key: @key, date: @date}
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

#offsets method - MOVED
  def square_date
    @date.to_i.pow(2).to_s
  end

#offsets method - MOVED
  def split_offset
    characters = []
    square_date.chars {|c| characters << c.to_i}
    characters.last(4)
  end

#offsets method - MOVED
  def offsets_by_shift
    @offset_pairs = {
                A: split_offset[0],
                B: split_offset[1],
                C: split_offset[2],
                D: split_offset[3]
              }
  end

#key method
  def randomize_key
    key = []
    5.times do
      key << @numbers.sample
    end
    key.join
  end

#key method
  def split_key
    characters = @key.chars
    characters.each_cons(2).map {|a,b| (a + b).to_i}
  end

#key method
  def keys_by_shift
    @key_pairs = {
                A: split_key[0],
                B: split_key[1],
                C: split_key[2],
                D: split_key[3]
              }
  end

  #shift method
  def shift_values
    @shifts = keys_by_shift.merge(offsets_by_shift) do |shift,key_value,offset_value|
      key_value + offset_value
    end
  end

#encrypt method
  def split_message
    @message.chars
  end

  def start_positions
    positions = {}
    split_message.each_with_index do |character, index|
      positions[index + 1] = character.downcase
    end
    positions
  end

  def encode
    a_rotated_alphabet = @alphabet.rotate(shift_values[:A])
    a_shift_alpha = Hash[@alphabet.zip a_rotated_alphabet]

    b_rotated_alphabet = @alphabet.rotate(shift_values[:B])
    b_shift_alpha = Hash[@alphabet.zip b_rotated_alphabet]

    c_rotated_alphabet = @alphabet.rotate(shift_values[:C])
    c_shift_alpha = Hash[@alphabet.zip c_rotated_alphabet]

    d_rotated_alphabet = @alphabet.rotate(shift_values[:D])
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

  def decode
    a_rotated_alphabet = @alphabet.rotate(shift_values[:A] * -1)
    a_shift_alpha = Hash[@alphabet.zip a_rotated_alphabet]

    b_rotated_alphabet = @alphabet.rotate(shift_values[:B] * -1)
    b_shift_alpha = Hash[@alphabet.zip b_rotated_alphabet]

    c_rotated_alphabet = @alphabet.rotate(shift_values[:C] * -1)
    c_shift_alpha = Hash[@alphabet.zip c_rotated_alphabet]

    d_rotated_alphabet = @alphabet.rotate(shift_values[:D] * -1)
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
