# Enigma

I started this project with the idea of creating all functionality in the Enigma class. Within that class I created functionality to create keys, offsets, the shift values, and I also created functionality to encrypt a message and decrypt a message. Once I had everything laid out in the Enigma class - I decided to split up the different functionalities into their own classes. 

I created three separate classes - one for Key, Offset, and Shift. 

I also created a new parent class called Code and created two new children classes Encryption and Decryption. An encryption and a decryption are both types of a code, they are messages that have been encoded in some way so it made sense for those two classes to inherit from the Code parent class. 

Once I split up all the functionality the Enigma class became responsible for the output of the encryption and decryption, as well as outputting the generated key and date. 

The encrypt.rb file and the decrypt.rb file allow for the command line interface. When encrypting, the command line interface has the option to take in a user generated key argument. It's limited to 5 digits - the program will pad it with leading zeros if less than 5 digits and will only us the first 5 digits if the user has entered in too many digits. 
