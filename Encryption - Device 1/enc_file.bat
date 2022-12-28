@echo off
Rem Extract your partner public key
openssl x509 -pubkey -noout -in task2/%1Certificate.pem  > task2/%1PublicKey.pem
Rem Generate a shared key
openssl rand  -hex -out task2/Task2sharedkey.bin 64
Rem Use partner’s public key to encrypt the Task2sharedkey.bin
openssl pkeyutl -encrypt -inkey task2/%1PublicKey.pem -pubin -in task2/Task2sharedkey.bin -out task2/Task2sharedkey.bin.enc
Rem Encrypt the Assignemt2_OpenSSL_Fall2021.pdf with the shared key
openssl enc -aes-256-cbc -pbkdf2 -in %2 -out task2/%2.enc -pass file:./task2/Task2sharedkey.bin
Rem Compute the Hash for the file
openssl dgst -sha256 -out task2/Task2.sha256 task2/%2.enc
Rem Sign the Task2.sha256 with private key
openssl dgst -sha256 -sign task1/RaedPrivateKey.pem -out task2/Task2sign.sha256 task2/Task2.sha256
Rem Verify the signed hash file with  public key
openssl dgst -sha256 -verify task1/RaedPublicKey.pem -signature task2/Task2sign.sha256 task2/Task2.sha256