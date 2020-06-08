require_relative 'shift'

class Code
  attr_reader :shift,
              :message,
              :alphabet
              
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

  def rotate(shift_values)
    @alphabet.rotate(shift_values)
  end

  def shifted_alphabet(shift_values)
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
end
