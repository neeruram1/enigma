require_relative 'code'

class Decryption < Code

  def decode
    ashift = @shift.shift_values[:A] * -1
    bshift = @shift.shift_values[:B] * -1
    cshift = @shift.shift_values[:C] * -1
    dshift = @shift.shift_values[:D] * -1
    message_position = start_positions
    message_position.map do |position, character|
      if included_in_a?(character, position)
        message_position[position] = shifted_alphabet(ashift)[character]
      elsif included_in_b?(character, position)
        message_position[position] = shifted_alphabet(bshift)[character]
      elsif included_in_c?(character, position)
      message_position[position] = shifted_alphabet(cshift)[character]
      elsif included_in_d?(character, position)
        message_position[position] = shifted_alphabet(dshift)[character]
      end
    end
    message_position.values.join
  end
end
