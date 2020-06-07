require './lib/enigma'
enigma = Enigma.new

message = File.open(ARGV[0], "r")
incoming_message = message.read
message.close

enigma.encrypt(incoming_message)
encryption = enigma.encrypt(incoming_message)[:encryption]

writer = File.open(ARGV[1], "w")
writer.write(encryption)
writer.close

puts "Created 'encrypted.txt' with the key #{enigma.key} and date #{enigma.date}"
