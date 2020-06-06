require 'date'
class Enigma
  attr_reader :numbers,
              :alphabet,
              :key
  def initialize
    @numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
    @alphabet = ("a".."z").to_a << " "
  end

  def encrypt(message, key = randomize_key, date = create_date)
    @key = key
    @date = date
    {encryption: message, key: key, date: date}
  end

  def randomize_key
    @key = []
    5.times do
      @key << @numbers.sample
    end
    @key.join
  end

  def convert_key_to_integer
    @key.to_i
  end

  def create_date
    @date = Date.today.strftime("%d%m%y")
  end

  def shift
    {A: 1, B: 2, C: 3, D: 4}
  end
end
