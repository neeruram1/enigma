require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/shift'
require './lib/key'
require './lib/offset'
require 'pry'

class ShiftTest < Minitest::Test
  def setup
    @shift = Shift.new
    @key = Key.new
    @offset = Offset.new
  end

  def test_it_exists
    assert_instance_of Shift, @shift
  end

  def test_it_has_attributes
    @shift.key.stubs(:randomize_key).returns("34753")
    @shift.offset.stubs(:date).returns("030620")
    expected = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]

    assert_equal expected, @shift.key.numbers
    assert_equal "030620", @shift.offset.date
  end

  def test_it_can_create_shift_values
    @shift.key.stubs(:randomize_key).returns("34753")
    @shift.offset.stubs(:date).returns("030620")
    expected = {
              A: 38,
              B: 51,
              C: 75,
              D: 53
            }
    assert_equal expected, @shift.shift_values
  end
end
