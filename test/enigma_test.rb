require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/enigma'
require 'pry'

class EnigmaTest < Minitest::Test
  def test_it_exists
    enigma = Enigma.new
    assert_instance_of Enigma, enigma
  end

  def test_it_has_attributes
    enigma = Enigma.new
    expected = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
    expected1 = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"," "]
    assert_equal expected, enigma.numbers
    assert_equal expected1, enigma.alphabet
  end

  def test_it_can_encrypt
    enigma = Enigma.new
    expected = {
              encryption: "keder ohulw",
              key: "02715",
              date: "040895"
            }
    assert_equal expected, enigma.encrypt("hello world", "02715", "040895")
  end

  def test_it_can_randomize_key_default_key
    enigma = Enigma.new
    enigma.stubs(:randomize_key).returns("34573")
    enigma.encrypt("hello world")

    assert_equal "34573", enigma.key
  end

  def test_it_can_generate_todays_date
    enigma = Enigma.new
    assert_equal "060620", enigma.create_date
  end

  def test_it_has_default_date
    enigma = Enigma.new
    enigma.stubs(:create_date).returns("030620")
    enigma.encrypt("hello world")

    assert_equal "030620", enigma.date
  end

  def test_it_can_split_key_into_pairs
    enigma = Enigma.new
    enigma.encrypt("HELLO WORLD", "34753", "030620")
    expected = [34, 47, 75, 53]

    assert_equal expected, enigma.split_key
  end

  def test_it_can_group_key_pairs_by_shift
    enigma = Enigma.new
    enigma.encrypt("HELLO WORLD", "34753", "030620")
    expected = {
              A: 34,
              B: 47,
              C: 75,
              D: 53
            }

    assert_equal expected, enigma.keys_by_shift
  end

  def test_it_can_square_date
    enigma = Enigma.new
    enigma.encrypt("HELLO WORLD", "34753", "030620")

    assert_equal "937584400", enigma.square_date
  end

  def test_it_can_return_last_four_digits_offset
    enigma = Enigma.new
    enigma.encrypt("HELLO WORLD", "34753", "030620")
    expected = [4, 4, 0, 0]

    assert_equal expected, enigma.split_offset
  end

  def test_it_can_group_offsets_by_shift
    enigma = Enigma.new
    enigma.encrypt("HELLO WORLD", "34753", "030620")
    expected = {
              A: 4,
              B: 4,
              C: 0,
              D: 0
            }

    assert_equal expected, enigma.offsets_by_shift
  end

  def test_it_can_create_shift_values
    enigma = Enigma.new
    enigma.encrypt("HELLO WORLD", "34753", "030620")
    expected = {
              A: 38,
              B: 51,
              C: 75,
              D: 53
            }

    assert_equal expected, enigma.shift_values
  end

  def test_it_can_split_message_characters
    enigma = Enigma.new
    enigma.encrypt("hello world", "34753", "030620")
    expected = ["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d"]

    assert_equal expected, enigma.split_message
  end

  def test_it_can_find_all_start_positions
    enigma = Enigma.new
    enigma.encrypt("HELLO WORLD", "02715", "040895")
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
    assert_equal expected, enigma.start_positions
  end

  def test_it_can_encode_message
    enigma = Enigma.new
    enigma.encrypt("HELLO WORLD", "02715", "040895")
    expected = "keder ohulw"
    assert_equal expected, enigma.encode
  end

  def test_it_can_encode_with_special_characters
    enigma = Enigma.new
    enigma.encrypt("HELLO WORLD!", "02715", "040895")
    expected = "keder ohulw!"
    assert_equal expected, enigma.encode
  end
end
