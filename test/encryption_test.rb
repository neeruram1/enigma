require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/shift'
require './lib/key'
require './lib/offset'
require './lib/encryption'

class EncryptionTest < Minitest::Test
  def setup
    @key = Key.new("02715")
    @offset = Offset.new("040895")
    @shift = Shift.new(@key, @offset)
    @encryption = Encryption.new(@shift, "hello world")
  end

  def test_it_exists
    assert_instance_of Encryption, @encryption
  end

  def test_it_has_attributes
    assert_equal @shift, @encryption.shift
    assert_equal "hello world", @encryption.message
  end

  def test_it_can_encode_message
    expected = "keder ohulw"
    assert_equal expected, @encryption.encode
  end

  def test_it_can_encode_with_special_characters
    encryption1 = Encryption.new(@shift, "hello world!")
    expected = "keder ohulw!"
    assert_equal expected, encryption1.encode
  end
end
