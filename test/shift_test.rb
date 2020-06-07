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
    @key = Key.new("02715")
    @offset = Offset.new("040895")
    @shift = Shift.new(@key, @offset)
  end

  def test_it_exists
    assert_instance_of Shift, @shift
  end

  def test_it_has_attributes
    assert_equal @key, @shift.key
    assert_equal @offset, @shift.offset
  end

  def test_it_can_create_shift_values
    expected = {
              A: 3,
              B: 27,
              C: 73,
              D: 20
            }
    assert_equal expected, @shift.shift_values
  end
end
