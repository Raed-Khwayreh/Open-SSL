@echo off
openssl x509 -pubkey -noout -in task3/%2Certificate.pem  > task3/%2PublicKey.pem
openssl pkeyutl -decrypt -in Task2sharedkey.bin.enc -out dec_sharedkey.bin -inkey task3/%1PrivateKey.pem
FC.exe /B dec_sharedkey.bin Task2sharedkey.bin
openssl enc -d -aes-256-cbc -pbkdf2 -in %3.enc -out DecFile.dec -pass file:./dec_sharedkey.bin
FC.exe /B %3 DecFile.dec

openssl dgst -sha256 -binary -out Task3.sha256 DecFile.dec
openssl dgst -sha256 -sign task3/%1PrivateKey.pem -out Task3sign.sha256 Task3.sha256
openssl dgst -sha256 -verify task3/%1PublicKey.pem -signature Task3sign.sha256 Task3.sha256