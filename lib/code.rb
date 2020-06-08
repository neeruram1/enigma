require_relative 'shift'

class Code
  attr_reader :shift,
              :message
  def initialize(shift, message)
    @shift = shift
    @message = message
    @alphabet = ("a".."z").to_a << " "
    @ashift = @shift.shift_values[:A]
    @bshift = @shift.shift_values[:B]
    @cshift = @shift.shift_values[:C]
    @dshift = @shift.shift_values[:D]
  end

  def start_positions
    positions = {}
    @message.chars.each_with_index do |character, index|
      positions[index + 1] = character.downcase
    end
    positions
  end

  def rotate(shift_values)
    @alphabet.rotate(shift_values)
  end

  def forward_shifted_alphabet(shift_values)
    Hash[@alphabet.zip rotate(shift_values)]
  end

  def backward_shifted_alphabet(shift_values)
    Hash[@alphabet.zip rotate(shift_values)]
  end

  def included_in_a?(character, position)
    @alphabet.include?(character) && position % 4 == 1
  end

  def included_in_b?(character, position)
    @alphabet.include?(character) && position % 4 == 2
  end

  def included_in_c?(character, position)
    @alphabet.include?(character) && position % 4 == 3
  end

  def included_in_d?(character, position)
    @alphabet.include?(character) && position % 4 == 0
  end

  def rotate_message_encode
    ashift = @shift.shift_values[:A]
    bshift = @shift.shift_values[:B]
    cshift = @shift.shift_values[:C]
    dshift = @shift.shift_values[:D]

    message_position = start_positions
    message_position.map do |position, character|
      if included_in_a?(character, position)
        message_position[position] = forward_shifted_alphabet(ashift)[character]
      elsif included_in_b?(character, position)
        message_position[position] = forward_shifted_alphabet(bshift)[character]
      elsif included_in_c?(character, position)
        message_position[position] = forward_shifted_alphabet(cshift)[character]
      elsif included_in_d?(character, position)
        message_position[position] = forward_shifted_alphabet(dshift)[character]
      end
    end
    message_position.values.join
  end

  def rotate_message_decode
    ashift = @shift.shift_values[:A] * -1
    bshift = @shift.shift_values[:B] * -1
    cshift = @shift.shift_values[:C] * -1
    dshift = @shift.shift_values[:D] * -1

    message_position = start_positions
    message_position.map do |position, character|
      if included_in_a?(character, position)
        message_position[position] = forward_shifted_alphabet(ashift)[character]
      elsif included_in_b?(character, position)
        message_position[position] = forward_shifted_alphabet(bshift)[character]
      elsif included_in_c?(character, position)
        message_position[position] = forward_shifted_alphabet(cshift)[character]
      elsif included_in_d?(character, position)
        message_position[position] = forward_shifted_alphabet(dshift)[character]
      end
    end
    message_position.values.join
  end
end
