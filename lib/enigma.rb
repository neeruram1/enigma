require 'date'
class Enigma
  attr_reader :numbers,
              :alphabet,
              :key,
              :data
  def initialize
    @numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
    @alphabet = ("a".."z").to_a << " "
    @data = {}
  end

  def encrypt(message, key = randomize_key, date = create_date)
    @data = {encryption: message, key: key, date: date}
  end

#offsets method
  def create_date
    Date.today.strftime("%d%m%y")
  end

#offsets method
  def square_date
    @data[:date].to_i.pow(2).to_s
  end

#offsets method
  def split_offset
    characters = []
    square_date.chars {|c| characters << c.to_i}
    characters.last(4)
  end

#offsets method
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
    characters = @data[:key].chars
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
    @data[:encryption].chars
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

    message = start_positions
    message.map do |position, character|
      if @alphabet.include?(message[position]) && (position + 4) % 4 == 1
        message[position] = a_shift_alpha[character]
      elsif @alphabet.include?(message[position]) && (position + 4) % 4 == 2
        message[position] = b_shift_alpha[character]
      elsif @alphabet.include?(message[position]) && (position + 4) % 4 == 3
        message[position] = c_shift_alpha[character]
      elsif @alphabet.include?(message[position]) && (position + 4) % 4 == 0
        message[position] = d_shift_alpha[character]
      end
    end
    message.values.join
  end
end
