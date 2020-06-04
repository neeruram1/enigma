require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/enigma'
require 'pry'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_has_attributes
    expected = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
    expected1 = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"," "]
    assert_equal expected, @enigma.numbers
    assert_equal expected1, @enigma.alphabet
  end

  def test_it_can_encrypt
    message = mock("encrypted message")
    expected = {
              encryption: message,
              key: "02715",
              date: "040895"
    }
    assert_equal expected, @enigma.encrypt(message, "02715", "040895")
  end

  def test_it_can_randomize_key_default_key
    @enigma.stubs(:randomize_key).returns("34573")

    assert_equal "34573", @enigma.encrypt("hello world")[:key]
  end

  def test_it_can_generate_todays_date
    assert_equal "030620", @enigma.create_date
  end

  def test_it_has_default_date
    @enigma.stubs(:create_date).returns("030620")
    assert_equal "030620", @enigma.encrypt("hello world")[:date]
  end

  def test_it_has_shift_start_positions
    expected = {A: 1, B: 2, C: 3, D: 4}
    assert_equal expected, @enigma.shift
  end
end
