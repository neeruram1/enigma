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
    skip
    enigma = Enigma.new
    expected = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
    expected1 = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"," "]
    assert_equal expected, enigma.numbers
    assert_equal expected1, enigma.alphabet
  end

  def test_it_can_encrypt
    skip
    enigma = Enigma.new
    expected = {
              encryption: "keder ohulw",
              key: "02715",
              date: "040895"
            }
    assert_equal expected, enigma.encrypt("hello world", "02715", "040895")
  end

  def test_it_can_decrypt
    skip
    enigma = Enigma.new
    expected = {
              decryption: "hello world",
              key: "02715",
              date: "040895"
            }
    assert_equal expected, enigma.decrypt("keder ohulw", "02715", "040895")
  end

  def test_it_has_default_date
    skip
    enigma = Enigma.new
    enigma.stubs(:create_date).returns("030620")
    enigma.encrypt("hello world")

    assert_equal "030620", enigma.date
  end

  def test_it_can_decode
    skip
    enigma = Enigma.new
    enigma.encrypt("keder ohulw!", "02715", "040895")
    expected = "hello world!"
    assert_equal expected, enigma.decode
  end
end
