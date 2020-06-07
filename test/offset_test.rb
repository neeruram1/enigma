require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/offset'
require 'pry'

class OffsetTest < Minitest::Test
  def setup
    @offset = Offset.new
    @offset.stubs(:date).returns("070620")
  end

  def test_it_exists
    assert_instance_of Offset, @offset
  end

  def test_it_has_attributes
    assert_equal "070620", @offset.date
    assert_equal ({}), @offset_pairs
  end

  def test_it_can_square_date
    assert_equal "4987184400", @offset.square_date
  end

  def test_it_can_return_last_four_digits_offset
    expected = [4, 4, 0, 0]
    assert_equal expected, @offset.split_offset
  end

  def test_it_can_group_offsets_by_shift
    expected = {
              A: 4,
              B: 4,
              C: 0,
              D: 0
            }
    assert_equal expected, @offset.offsets_by_shift
    binding.pry
  end
end
