require './lib/enigma'
enigma = Enigma.new

message = File.open(ARGV[0], "r")
encrypted_message = message.read
message.close

enigma.decrypt(encrypted_message, ARGV[2], ARGV[3])
decryption = enigma.decrypt(encrypted_message, ARGV[2], ARGV[3])[:decryption]

writer = File.open(ARGV[1], "w")
writer.write(decryption)
writer.close

puts "Created 'decrypted.txt' with the key #{enigma.key} and date #{enigma.date}"
