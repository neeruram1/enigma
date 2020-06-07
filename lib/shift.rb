class Shift
  attr_reader :key,
              :offset
  def initialize
    @key = Key.new
    @offset = Offset.new
  end

  def shift_values
    @shifts = @key.keys_by_shift.merge(@offset.offsets_by_shift) do |shift,key_value,offset_value|
      key_value + offset_value
    end
  end

end
