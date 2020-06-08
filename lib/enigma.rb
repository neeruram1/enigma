require 'date'
require_relative 'shift'
require_relative 'key'
require_relative 'offset'
require_relative 'encryption'
require_relative 'decryption'
require_relative 'shift'



class Enigma
  attr_reader :encrypt_data,
              :decrypt_data
  def initialize
    @encrypt_data = {}
    @decrypt_data = {}
  end

  def encrypt(message, key_param = Key.new.key, date_param = Offset.new.date)
    date = Offset.new(date_param)
    key = Key.new(key_param)
    shift = Shift.new(key, date)
    encryption = Encryption.new(shift, message)
    @encrypt_data = {encryption: encryption.encode, key: key.key, date: date.date}
  end

  def decrypt(message, key_param = Key.new.key, date_param = Offset.new.date)
    date = Offset.new(date_param)
    key = Key.new(key_param)
    shift = Shift.new(key, date)
    decryption = Decryption.new(shift, message)
    @decrypt_data = {decryption: decryption.decode, key: key.key, date: date.date}
  end
end
