class Key
  attr_reader :key

  def self.randomize_key
    numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
    key = []
    5.times do
      key << numbers.sample
    end
    key.join
  end

  def initialize(key = Key.randomize_key)
    @key = key
  end

  def split_key
    characters = @key.chars
    characters.each_cons(2).map {|a,b| (a + b).to_i}
  end

  def keys_by_shift
    {
      A: split_key[0],
      B: split_key[1],
      C: split_key[2],
      D: split_key[3]
    }
  end
end
