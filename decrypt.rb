require './lib/enigma'
enigma = Enigma.new

message = File.open(ARGV[0], "r")
encrypted_message = message.read
message.close

enigma.decrypt(encrypted_message, ARGV[2], ARGV[3])
decryption = enigma.decrypt(encrypted_message, ARGV[2], ARGV[3])[:decryption]
key = enigma.decrypt_data[:key]
date = enigma.decrypt_data[:date]

writer = File.open(ARGV[1], "w")
writer.write(decryption)
writer.close

puts "\nCreated 'decrypted.txt' with the key #{key} and date #{date}\n"
puts "\nThis program will now self destruct. Have a wonderful day!\n"
