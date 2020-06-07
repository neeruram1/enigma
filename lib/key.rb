class Key
  attr_reader :numbers,
              :key_pairs
  def initialize
    @numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
    @key_pairs = {}
  end

  def randomize_key
    key = []
    5.times do
      key << @numbers.sample
    end
    key.join
  end

  def split_key
    characters = randomize_key.chars
    characters.each_cons(2).map {|a,b| (a + b).to_i}
  end

  def keys_by_shift
    @key_pairs = {
                A: split_key[0],
                B: split_key[1],
                C: split_key[2],
                D: split_key[3]
              }
  end
end
