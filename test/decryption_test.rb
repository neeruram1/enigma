require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/shift'
require './lib/key'
require './lib/offset'
require './lib/decryption'

class DecryptionTest < Minitest::Test
  def setup
    @key = Key.new("02715")
    @offset = Offset.new("040895")
    @shift = Shift.new(@key, @offset)
    @decryption = Decryption.new(@shift, "keder ohulw")
  end

  def test_it_exists
    assert_instance_of Decryption, @decryption
  end

  def test_it_has_attributes
    assert_equal @shift, @decryption.shift
    assert_equal "keder ohulw", @decryption.message
  end

  def test_it_can_decode_message
    expected = "hello world"
    assert_equal expected, @decryption.decode
  end
end
