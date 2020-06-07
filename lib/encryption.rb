class Encryption
  attr_reader :shift,
              :message

  def initialize(shift, message)
    @shift = shift
    @message = message
    @alphabet = ("a".."z").to_a << " "
  end

  def start_positions
    positions = {}
    @message.chars.each_with_index do |character, index|
      positions[index + 1] = character.downcase
    end
    positions
  end

  def encode
    a_rotated_alphabet = @alphabet.rotate(@shift.shift_values[:A])
    a_shift_alpha = Hash[@alphabet.zip a_rotated_alphabet]

    b_rotated_alphabet = @alphabet.rotate(@shift.shift_values[:B])
    b_shift_alpha = Hash[@alphabet.zip b_rotated_alphabet]

    c_rotated_alphabet = @alphabet.rotate(@shift.shift_values[:C])
    c_shift_alpha = Hash[@alphabet.zip c_rotated_alphabet]

    d_rotated_alphabet = @alphabet.rotate(@shift.shift_values[:D])
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
