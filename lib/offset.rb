require 'date'

class Offset
  attr_reader :date

  def self.today_date
    Date.today.strftime("%d%m%y")
  end

  def initialize(date = Offset.today_date)
    @date = date
  end

  def square_date
    @date.to_i.pow(2).to_s
  end

  def split_offset
  characters = []
    square_date.chars {|c| characters << c.to_i}
    characters.last(4)
  end

  def offsets_by_shift
  {
    A: split_offset[0],
    B: split_offset[1],
    C: split_offset[2],
    D: split_offset[3]
  }
  end
end
