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

  def create_date
    @date = Date.today.strftime("%d%m%y")
  end

  def randomize_key
    @key = []
    5.times do
      @key << @numbers.sample
    end
    @key.join
  end

  def split_key
    char = []
    @key.each_char {|c| char << c}
    char.each_cons(2).map {|a,b| (a + b).to_i}
  end

  def group_keys_by_shift
    @key_pairs = {
                A: split_key[0],
                B: split_key[1],
                C: split_key[2],
                D: split_key[3]
              }
  end
end
