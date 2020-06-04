require 'date'
class Enigma
  attr_reader :numbers,
              :alphabet,
              :key
  def initialize
    @numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
    @alphabet = ("a".."z").to_a << " "
    @key = []
  end

  def encrypt(message, key = randomize_key, date)
    {encryption: message, key: key, date: date}
  end

  def randomize_key
    5.times do
      @key << @numbers.sample
    end
    @key.join
  end
end
