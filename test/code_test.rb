require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/shift'
require './lib/key'
require './lib/offset'
require './lib/encryption'

class CodeTest < Minitest::Test
  def setup
    @message = "hello world"
    @message1 = "hello world!"
    @message2 = "keder ohulw"
    @key = Key.new("02715")
    @offset = Offset.new("040895")
    @shift = Shift.new(@key, @offset)
    @code = Code.new(@shift, @message)
    @code1 = Code.new(@shift, @message1)
    @code2 = Code.new(@shift, @message2)
  end

  def test_it_exists
    assert_instance_of Code, @code
  end

  def test_it_has_attributes
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"," "]
    assert_equal @shift, @code.shift
    assert_equal @message, @code.message
    assert_equal expected, @code.alphabet
  end

  def test_it_can_find_all_start_positions
    expected = {
              1 => "h",
              2 => "e",
              3 => "l",
              4 => "l",
              5 => "o",
              6 => " ",
              7 => "w",
              8 => "o",
              9 => "r",
              10 => "l",
              11 => "d"
            }
      assert_equal expected, @code.start_positions
  end

  def test_it_can_rotate_alphabet
    expected = ["d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p",  "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ", "a", "b", "c"]
    assert_equal expected, @code.rotate(@shift.shift_values[:A])
  end

  def test_it_is_included_in_a
    assert_equal true, @code.included_in_a?(@code.start_positions.first[1],   @code.start_positions.first[0])
  end

  def test_it_is_included_in_a
    assert_equal false, @code.included_in_b?(@code.start_positions.first[1], @code.start_positions.first[0])
  end

  def test_it_is_included_in_c
    assert_equal false, @code.included_in_c?(@code.start_positions.first[1], @code.start_positions.first[0])
  end

  def test_it_is_included_in_d
    assert_equal false, @code.included_in_d?(@code.start_positions.first[1], @code.start_positions.first[0])
  end
end
