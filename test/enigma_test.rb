require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/enigma'
require 'pry'

class EnigmaTest < Minitest::Test
  def setup


  end
  def test_it_exists
    enigma = Enigma.new
    assert_instance_of Enigma, enigma
  end


end
