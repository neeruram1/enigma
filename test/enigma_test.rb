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

  def test_it_can_decrypt
    enigma = Enigma.new
    expected = {
              decryption: "hello world",
              key: "02715",
              date: "040895"
            }
    assert_equal expected, enigma.decrypt("keder ohulw", "02715", "040895")
  end

  def test_it_has_default_date
    enigma = Enigma.new
    enigma.stubs(:create_date).returns("030620")
    enigma.encrypt("hello world")

    assert_equal "030620", enigma.date
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

  def test_it_can_decode
    enigma = Enigma.new
    enigma.encrypt("keder ohulw!", "02715", "040895")
    expected = "hello world!"
    assert_equal expected, enigma.decode
  end
end
