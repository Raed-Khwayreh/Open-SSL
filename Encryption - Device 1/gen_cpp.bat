@echo off
Rem  Generate Private key and Self-signed Certificate
openssl req -newkey rsa:2048 -nodes -keyout task1/%1PrivateKey.pem -x509 -days 365 -out task1/%1Certificate.pem
Rem Extract your Public Key from the certificate
openssl x509 -pubkey -noout -in task1/%1Certificate.pem  > task1/%1PublicKey.pem
Rem Launch Notepad++ or notepad to display the three generated
start notepad task1/%1PrivateKey.pem
start notepad task1/%1PublicKey.pem
start notepad task1/%1Certificate.pem 